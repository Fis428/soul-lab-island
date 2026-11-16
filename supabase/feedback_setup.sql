-- 登大人島｜回饋與聯絡頁（/feedback/）資料表
-- 用法：Supabase 後台 → SQL Editor → New query → 整段貼上 → Run（只要跑一次）
--
-- 兩張表刻意分開、沒有任何欄位互相連結：
--   feedback  匿名回饋（兩題），只能看統計，不知道是誰回答的
--   contacts  願意被聯絡的人，只用來寄信邀請參與
-- 來賓（anon）只能「新增」，不能讀、改、刪；阿狗用 Supabase 後台查看與匯出。

-- 1. 匿名回饋
create table if not exists public.feedback (
  id          bigint generated always as identity primary key,
  created_at  timestamptz not null default now(),
  understand  text not null check (understand in ('看懂','大概懂','不太懂')),
  would_use   text not null check (would_use in ('會','也許','不會')),
  source      text check (char_length(source) <= 20)
);

-- 2. 聯絡名單
create table if not exists public.contacts (
  id          bigint generated always as identity primary key,
  created_at  timestamptz not null default now(),
  interests   text[] not null
              check (cardinality(interests) between 1 and 4
                     and interests <@ array['tester','builder','professional','resource']),
  name        text check (char_length(name) <= 60),
  email       text not null check (char_length(email) <= 200 and email ~* '^[^@\s]+@[^@\s]+\.[^@\s]+$'),
  social      text check (char_length(social) <= 100),
  about       text check (char_length(about) <= 500),
  consent     boolean not null check (consent = true),
  source      text check (char_length(source) <= 20),
  unsubscribed boolean not null default false   -- 有人說要退出：改成 true，或直接刪掉那一列
);

-- 3. 權限：開啟 RLS，只允許新增
alter table public.feedback enable row level security;
alter table public.contacts enable row level security;

drop policy if exists "anyone can submit feedback" on public.feedback;
create policy "anyone can submit feedback" on public.feedback
  for insert to anon, authenticated with check (true);

drop policy if exists "anyone can leave contact" on public.contacts;
create policy "anyone can leave contact" on public.contacts
  for insert to anon, authenticated with check (unsubscribed = false);

revoke all on public.feedback, public.contacts from anon, authenticated;
grant insert (understand, would_use, source) on public.feedback to anon, authenticated;
grant insert (interests, name, email, social, about, consent, source) on public.contacts to anon, authenticated;

-- 4. 方便看統計的查詢（在 SQL Editor 跑；來賓看不到）
-- select understand, count(*) from public.feedback group by 1;
-- select would_use,  count(*) from public.feedback group by 1;
-- select unnest(interests) as 類別, count(*) from public.contacts where not unsubscribed group by 1;
