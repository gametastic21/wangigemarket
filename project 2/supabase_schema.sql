-- Wangige Market Clothing - Supabase database setup
-- Run this entire script in Supabase SQL Editor.

create extension if not exists pgcrypto;

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  category text not null,
  price numeric(10,2) not null default 0,
  old_price numeric(10,2),
  rating numeric(2,1) default 0,
  reviews integer default 0,
  description text default '',
  sizes text[] default '{}',
  colors text[] default '{}',
  has_kit_type boolean default false,
  kit_types text[] default '{}',
  default_image text,
  variant_images jsonb default '{}'::jsonb,
  in_stock boolean default true,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists public.site_settings (
  id integer primary key default 1,
  whatsapp_number text not null default '254705624535',
  hero_image text,
  about_image text,
  logo_image text,
  updated_at timestamptz default now()
);

insert into public.site_settings (id, whatsapp_number)
values (1, '254705624535')
on conflict (id) do nothing;

-- Public customers can read products/settings.
alter table public.products enable row level security;
alter table public.site_settings enable row level security;

drop policy if exists "Public can view products" on public.products;
create policy "Public can view products"
on public.products for select
to anon, authenticated
using (true);

drop policy if exists "Public can view site settings" on public.site_settings;
create policy "Public can view site settings"
on public.site_settings for select
to anon, authenticated
using (true);

-- Logged-in admins can manage products/settings.
drop policy if exists "Admins can manage products" on public.products;
create policy "Admins can manage products"
on public.products for all
to authenticated
using (true)
with check (true);

drop policy if exists "Admins can manage site settings" on public.site_settings;
create policy "Admins can manage site settings"
on public.site_settings for all
to authenticated
using (true)
with check (true);

-- Storage bucket for product and website images.
insert into storage.buckets (id, name, public)
values ('wangige-images', 'wangige-images', true)
on conflict (id) do update set public = true;

drop policy if exists "Public can view Wangige images" on storage.objects;
create policy "Public can view Wangige images"
on storage.objects for select
to anon, authenticated
using (bucket_id = 'wangige-images');

drop policy if exists "Authenticated users can upload Wangige images" on storage.objects;
create policy "Authenticated users can upload Wangige images"
on storage.objects for insert
to authenticated
with check (bucket_id = 'wangige-images');

drop policy if exists "Authenticated users can update Wangige images" on storage.objects;
create policy "Authenticated users can update Wangige images"
on storage.objects for update
to authenticated
using (bucket_id = 'wangige-images')
with check (bucket_id = 'wangige-images');

drop policy if exists "Authenticated users can delete Wangige images" on storage.objects;
create policy "Authenticated users can delete Wangige images"
on storage.objects for delete
to authenticated
using (bucket_id = 'wangige-images');

-- Optional starter products are NOT inserted automatically.
-- The admin dashboard can create them from scratch or you can import your
-- existing hard-coded catalog later.
