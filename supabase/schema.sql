-- MathRadar V1 database schema
-- Supabase Dashboard > SQL Editor icinde tek seferde calistirilabilir.

create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null default '',
  role text not null check (role in ('teacher', 'parent', 'student')),
  created_at timestamptz not null default now()
);

create table if not exists public.students (
  id uuid primary key default gen_random_uuid(),
  user_id uuid unique references auth.users(id) on delete set null,
  teacher_id uuid not null references auth.users(id) on delete cascade,
  full_name text not null,
  grade int not null default 4 check (grade between 1 and 12),
  created_at timestamptz not null default now()
);

create table if not exists public.parent_students (
  parent_id uuid not null references auth.users(id) on delete cascade,
  student_id uuid not null references public.students(id) on delete cascade,
  primary key (parent_id, student_id)
);

create table if not exists public.topics (
  id uuid primary key default gen_random_uuid(),
  grade int not null,
  title text not null,
  sort_order int not null default 0,
  unique (grade, title)
);

create table if not exists public.lessons (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references public.students(id) on delete cascade,
  teacher_id uuid not null references auth.users(id) on delete cascade,
  lesson_date timestamptz not null default now(),
  summary text not null default '',
  understanding int check (understanding between 1 and 5),
  focus int check (focus between 1 and 5),
  participation int check (participation between 1 and 5),
  created_at timestamptz not null default now()
);

create table if not exists public.question_results (
  id uuid primary key default gen_random_uuid(),
  lesson_id uuid not null references public.lessons(id) on delete cascade,
  student_id uuid not null references public.students(id) on delete cascade,
  topic_id uuid references public.topics(id) on delete set null,
  is_correct boolean not null,
  error_type text check (error_type in (
    'topic_gap', 'calculation', 'attention', 'misread',
    'problem_reasoning', 'incomplete', 'time_management'
  )),
  difficulty int check (difficulty between 1 and 5),
  confidence int check (confidence between 1 and 3),
  created_at timestamptz not null default now()
);

create table if not exists public.homeworks (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references public.students(id) on delete cascade,
  teacher_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  total_questions int not null default 0,
  completed_questions int not null default 0,
  due_at timestamptz,
  created_at timestamptz not null default now()
);

create table if not exists public.student_topic_progress (
  student_id uuid not null references public.students(id) on delete cascade,
  topic_id uuid not null references public.topics(id) on delete cascade,
  mastery numeric(5,2) not null default 0 check (mastery between 0 and 100),
  updated_at timestamptz not null default now(),
  primary key (student_id, topic_id)
);

-- RLS helper functions SECURITY DEFINER ile calisir; boylece policy'ler
-- birbirini recursive sekilde tetiklemeden erisim kontrolu yapabilir.
create or replace function public.can_access_student(p_student_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.students s
    left join public.parent_students ps on ps.student_id = s.id
    where s.id = p_student_id
      and (
        s.teacher_id = auth.uid()
        or s.user_id = auth.uid()
        or ps.parent_id = auth.uid()
      )
  );
$$;

create or replace function public.is_teacher_of_student(p_student_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1 from public.students s
    where s.id = p_student_id and s.teacher_id = auth.uid()
  );
$$;

grant execute on function public.can_access_student(uuid) to authenticated;
grant execute on function public.is_teacher_of_student(uuid) to authenticated;

alter table public.profiles enable row level security;
alter table public.students enable row level security;
alter table public.parent_students enable row level security;
alter table public.topics enable row level security;
alter table public.lessons enable row level security;
alter table public.question_results enable row level security;
alter table public.homeworks enable row level security;
alter table public.student_topic_progress enable row level security;

create policy "profiles_select_own" on public.profiles
for select to authenticated using (id = auth.uid());
create policy "profiles_update_own" on public.profiles
for update to authenticated using (id = auth.uid()) with check (id = auth.uid());

create policy "topics_read_authenticated" on public.topics
for select to authenticated using (true);

create policy "students_read_related" on public.students
for select to authenticated using (public.can_access_student(id));
create policy "students_teacher_insert" on public.students
for insert to authenticated with check (teacher_id = auth.uid());
create policy "students_teacher_update" on public.students
for update to authenticated using (teacher_id = auth.uid()) with check (teacher_id = auth.uid());
create policy "students_teacher_delete" on public.students
for delete to authenticated using (teacher_id = auth.uid());

create policy "parent_students_read_related" on public.parent_students
for select to authenticated using (public.can_access_student(student_id));
create policy "parent_students_teacher_insert" on public.parent_students
for insert to authenticated with check (public.is_teacher_of_student(student_id));
create policy "parent_students_teacher_delete" on public.parent_students
for delete to authenticated using (public.is_teacher_of_student(student_id));

create policy "lessons_read_related" on public.lessons
for select to authenticated using (public.can_access_student(student_id));
create policy "lessons_teacher_insert" on public.lessons
for insert to authenticated with check (
  teacher_id = auth.uid() and public.is_teacher_of_student(student_id)
);
create policy "lessons_teacher_update" on public.lessons
for update to authenticated using (
  teacher_id = auth.uid() and public.is_teacher_of_student(student_id)
) with check (
  teacher_id = auth.uid() and public.is_teacher_of_student(student_id)
);
create policy "lessons_teacher_delete" on public.lessons
for delete to authenticated using (
  teacher_id = auth.uid() and public.is_teacher_of_student(student_id)
);

create policy "question_results_read_related" on public.question_results
for select to authenticated using (public.can_access_student(student_id));
create policy "question_results_teacher_insert" on public.question_results
for insert to authenticated with check (public.is_teacher_of_student(student_id));
create policy "question_results_teacher_update" on public.question_results
for update to authenticated using (public.is_teacher_of_student(student_id))
with check (public.is_teacher_of_student(student_id));
create policy "question_results_teacher_delete" on public.question_results
for delete to authenticated using (public.is_teacher_of_student(student_id));

create policy "homeworks_read_related" on public.homeworks
for select to authenticated using (public.can_access_student(student_id));
create policy "homeworks_teacher_insert" on public.homeworks
for insert to authenticated with check (
  teacher_id = auth.uid() and public.is_teacher_of_student(student_id)
);
create policy "homeworks_teacher_update" on public.homeworks
for update to authenticated using (
  teacher_id = auth.uid() and public.is_teacher_of_student(student_id)
) with check (
  teacher_id = auth.uid() and public.is_teacher_of_student(student_id)
);
create policy "homeworks_teacher_delete" on public.homeworks
for delete to authenticated using (
  teacher_id = auth.uid() and public.is_teacher_of_student(student_id)
);

create policy "progress_read_related" on public.student_topic_progress
for select to authenticated using (public.can_access_student(student_id));
create policy "progress_teacher_insert" on public.student_topic_progress
for insert to authenticated with check (public.is_teacher_of_student(student_id));
create policy "progress_teacher_update" on public.student_topic_progress
for update to authenticated using (public.is_teacher_of_student(student_id))
with check (public.is_teacher_of_student(student_id));
create policy "progress_teacher_delete" on public.student_topic_progress
for delete to authenticated using (public.is_teacher_of_student(student_id));

insert into public.topics (grade, title, sort_order) values
  (4, 'Dogal Sayilar', 10),
  (4, 'Toplama ve Cikarma', 20),
  (4, 'Carpma ve Bolme', 30),
  (4, 'Problemler', 40),
  (4, 'Kesirler', 50),
  (4, 'Olcme', 60),
  (4, 'Geometri', 70)
on conflict (grade, title) do nothing;
