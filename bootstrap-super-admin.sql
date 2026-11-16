-- Create the user first in Supabase Auth, then replace the email below and run.
insert into public.profiles(id,email,role) select id,email,'super_admin' from auth.users where email='YOUR_ADMIN_EMAIL' on conflict(id) do update set role='super_admin',email=excluded.email;
