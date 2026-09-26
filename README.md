# MathRadar

4. sinif matematik ozel dersleri icin ogretmen, veli ve ogrenci takip uygulamasi.

## V0.1 neler var?
- Ogretmen dashboard onizlemesi
- Ogrenci detay ve gelisim ekrani
- Hata DNA'si onizlemesi
- Ders takip ekrani
- Veli dashboard onizlemesi
- Supabase icin hazir konfigurasyon noktasi
- Ilk PostgreSQL + RLS semasi
- GitHub Actions ile otomatik Android APK build

## Demo modu
Supabase bilgileri verilmeden uygulama demo verilerle acilir. Bu, GitHub Actions ve APK akisini backend kurmadan test etmeyi saglar.

## Supabase modu
Build sirasinda su degerler verildiginde Supabase baslatilir:
- `SUPABASE_URL`
- `SUPABASE_PUBLISHABLE_KEY`

GitHub Actions bunlari repository variable/secret olarak alir.

## APK
Detayli Turkce kurulum ve build adimlari icin `GITHUB_STEPS_TR.md` dosyasina bak.

## Mimari

```text
Flutter Android App
        |
        | HTTPS
        v
Supabase Cloud
  |- Auth
  |- PostgreSQL
  |- Row Level Security
  |- Storage (sonraki asama)
  `- Realtime (sonraki asama)
```

## Guvenlik notu
Mobil uygulamaya sadece Supabase client/publishable key konur. `service_role` veya sunucu secret anahtari mobil uygulamaya gomulmez. Gercek veri erisimi RLS politikalarina gore sinirlanir.
