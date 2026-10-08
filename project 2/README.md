# Wangige Market — Admin Edition

This package adds a real admin dashboard to the existing storefront.

## What it gives you

- Admin login using Supabase Authentication.
- Add new products.
- Edit product name, category, price, old price, description, sizes, colors and stock.
- Replace a product's main image by uploading a new image.
- Mark products IN STOCK / OUT OF STOCK.
- Delete products.
- Upload/replace the website logo, hero image and About/Shop image.
- Change the WhatsApp number from the admin dashboard.
- Current WhatsApp number is set to +254705624535.
- Images are stored in Supabase Storage, not inside the HTML.
- Product data is stored in Supabase Database.

## Important

The current storefront is still built around a hard-coded `products` JavaScript array. The included `admin.html` is the management interface, but for customer changes to appear automatically, the storefront must also be changed to load products/settings from Supabase.

The next integration step is to replace the hard-coded catalog rendering in `index.html` with a Supabase-backed loader. That should be done after your Supabase project is created because the storefront needs the project URL/key.

## Setup

1. Create a Supabase project.
2. In Supabase SQL Editor, run `supabase_schema.sql`.
3. In Authentication > Users, create your private admin account.
4. Copy your Supabase Project URL and anon/publishable key into `config.js`.
5. Deploy `index.html`, `admin.html`, and `config.js` together.
6. Open `admin.html` and log in.
7. Add/edit products.

Never put a Supabase `service_role`/secret key in `config.js` or frontend JavaScript.

## WhatsApp

The desired number `0705624535` is stored/used internationally as `254705624535`.
