# MathRadar - GitHub uzerinden APK alma

## 1) GitHub'da yeni repository ac
1. github.com > New repository
2. Repository name: `math-radar`
3. Private secmeni oneririm.
4. README / .gitignore / license ekleme. Bu proje zaten bunlari iceriyor.
5. `Create repository`.

## 2) Bu klasorun ICERIGINI GitHub'a yukle
ZIP dosyasinin kendisini repo'ya koyma. ZIP'i bilgisayarinda ac ve icindeki dosyalari repository kokune yukle.

Repository kokunde sunlari gormelisin:
- `.github/`
- `lib/`
- `supabase/`
- `test/`
- `pubspec.yaml`
- `README.md`

GitHub web arayuzunden: `Add file` > `Upload files` > dosyalari surukle > `Commit changes`.

> Not: GitHub web arayuzu bos klasorleri yuklemez; bu projede gerekli klasorlerin hepsinde dosya var.

## 3) APK build'ini baslat
`main` branch'e ilk yukleme yapildiginda workflow otomatik baslar.

Kontrol etmek icin:
1. Repository > `Actions`
2. Sol tarafta `Build Android APK`
3. En ustteki calismayi ac
4. Tum adimlar yesil ise build tamamdir.

Manuel calistirmak icin:
`Actions` > `Build Android APK` > `Run workflow`.

## 4) APK'yi indir
Build bittikten sonra workflow sayfasinin altinda `Artifacts` bolumu cikar.

`MathRadar-Android` dosyasini indir. GitHub bunu ZIP olarak indirir. ZIP'in icinden:

`MathRadar.apk`

cikar. Android telefonuna gonderip kurabilirsin.

## 5) Ilk build Supabase olmadan da calisir
Supabase URL/key eklenmemisse uygulama `Demo` modunda acilir. Bu sayede once APK pipeline'inin calistigini dogrulariz.

## 6) Supabase'i ortak server olarak bagla
Supabase'de yeni proje actiktan sonra:

### Repository variable
GitHub repo > Settings > Secrets and variables > Actions > Variables > New repository variable

Name: `SUPABASE_URL`
Value: Supabase Project URL

### Repository secret
GitHub repo > Settings > Secrets and variables > Actions > Secrets > New repository secret

Name: `SUPABASE_PUBLISHABLE_KEY`
Value: Supabase Connect panelindeki publishable key

Sonra Actions workflow'unu tekrar calistir.

> `service_role` / secret server key APK icine KESINLIKLE koyma.

## 7) Veritabanini kur
Supabase Dashboard > SQL Editor > New query.

Bu projedeki `supabase/schema.sql` dosyasinin tamamini kopyala, SQL Editor'e yapistir ve Run'a bas.

Bu V1 semasi su yapilari olusturur:
- profiles
- students
- parent_students
- topics
- lessons
- question_results
- homeworks
- student_topic_progress
- Row Level Security politikalarinin ilk surumu

## 8) Sonraki gelistirme adimi
APK pipeline'i ve Supabase schema dogrulandiktan sonra su sirayla ilerlemek mantikli:
1. Teacher / Parent / Student login
2. Gercek ogrenci ekleme
3. Ders kaydi
4. Soru ve hata tipi kaydi
5. Odev sistemi
6. Veli dashboardunun gercek veriye baglanmasi
7. XP/rozet/oyunlastirma
8. Haftalik rapor
