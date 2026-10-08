-- Run once in Supabase SQL Editor, after your supabase_schema.sql. Safe to re-run.

-- 1. Column for the shop/stall photo (admin "Website images" tab)
alter table public.site_settings add column if not exists shop_image text;

-- 2. Turn on live updates so the store changes the moment you save in admin
do $$ begin
  begin alter publication supabase_realtime add table public.products; exception when duplicate_object then null; end;
  begin alter publication supabase_realtime add table public.site_settings; exception when duplicate_object then null; end;
end $$;
