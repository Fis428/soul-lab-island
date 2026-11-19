# soul-lab-island
登大人島｜Soul Lab 展演互動網頁 v0.4

## 網址（GitHub Pages）
| 頁面 | 網址 | 檔案 |
| --- | --- | --- |
| 小島主網站 | https://fis428.github.io/soul-lab-island/ | `index.html` |
| 回饋與聯絡頁 | https://fis428.github.io/soul-lab-island/feedback/ | `feedback/index.html` |
| 脫鉤練習（測試版） | https://fis428.github.io/soul-lab-island/defuse/ | `defuse/index.html` |
| 回到當下練習（測試版） | https://fis428.github.io/soul-lab-island/present/ | `present/index.html` |

脫鉤、回到當下是 10 月下旬做第一輪測試用的獨立版（含 3 天後回顧、複製回饋卡貼到 LINE），內容和小島裡浪板小屋的單元不完全相同。進度只存在使用者自己的瀏覽器（localStorage），不上傳。

## 回饋與聯絡頁 `/feedback/`
展場郵箱 NFC／QR 連到這頁。網址加 `?from=nfc`、`?from=qr`、`?from=web` 記錄入口；展場平板用 `?from=kiosk` 會出現「給下一位來賓」按鈕。
資料存在 Supabase：先在 SQL Editor 跑 `supabase/feedback_setup.sql`，Project URL 和 anon key 已填進 `feedback/index.html`（Supabase 專案 soul-lab-island，東京）。
