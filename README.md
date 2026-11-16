# soul-lab-island
登大人島｜Soul Lab 展演互動網頁 v0.4

## 回饋與聯絡頁 `/feedback/`
展場郵箱 NFC／QR 連到這頁。網址加 `?from=nfc`、`?from=qr`、`?from=web` 記錄入口；展場平板用 `?from=kiosk` 會出現「給下一位來賓」按鈕。
資料存在 Supabase：先在 SQL Editor 跑 `supabase/feedback_setup.sql`，Project URL 和 anon key 已填進 `feedback/index.html`（Supabase 專案 soul-lab-island，東京）。
