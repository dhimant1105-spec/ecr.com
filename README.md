# PF Statutory & ECR Management — starter project

## Included
- Supabase email/password authentication.
- Super Admin-only company provisioning (protected Edge Function).
- Company Admin / Company User roles.
- Company-level PostgreSQL Row Level Security (RLS).
- **Option B:** Super Admin and Company Admin can edit statutory settings; ordinary users are read-only.
- Employee master manual entry and bulk CSV upload.
- Monthly PF wage CSV upload and contribution calculations.
- Whole-rupee rounding.
- ECR preview and draft `.txt` export.
- Filing confirmation fields (filing date, TRRN, challan, payment date/status).
- Company-scoped monthly reports (CSV and browser print/PDF).
- Audit entries for key application actions.

## Setup
1. Create a Supabase project.
2. Run `supabase/schema.sql` in Supabase SQL Editor.
3. Create the first user in Supabase Authentication.
4. Replace `YOUR_ADMIN_EMAIL` in `supabase/bootstrap-super-admin.sql` and run it to assign Super Admin role.
5. Deploy `supabase/functions/admin-create-company` as an Edge Function. Supabase supplies URL, anon and service-role secrets to the function. Never expose the service-role key in frontend code.
6. In `app.js`, replace `YOUR_SUPABASE_PROJECT_URL` and `YOUR_SUPABASE_ANON_KEY`. The anon key is intended for frontend use when RLS is enabled.
7. Publish `index.html`, `styles.css`, `app.js` to GitHub Pages. The backend remains on Supabase.
8. Test with two separate companies and verify cross-company access is denied.

## CSV templates
Employee: `employee_code,uan,employee_name,date_of_joining,date_of_exit,pension_member,epf_eligible,status,remarks`
Wages: `employee_code,uan,pf_wages,pension_wages,days_worked,ncp_days,refund_of_advances`

UAN must be 12 digits. One employee row per company/month. Use CSV files in this starter; XLSX import and row-level preview/error download are not yet implemented.

## Critical production limitations
- The ECR `.txt` export is a **draft adapter**, not certified as the current EPFO upload format. The exact current official schema, version, field order, validations, encoding and upload acceptance must be verified and implemented before statutory filing.
- Sample rates and ceilings are configurable starter values only. Confirm current EPFO/EPS/EDLI rates, wage ceilings, eligibility, rounding and exceptions against current official notifications and qualified compliance advice.
- The calculation engine is a baseline. Add and test special cases such as excluded employees, higher wages, international workers, date-of-joining/exit proration, EDLI exemptions and all applicable statutory exceptions.
- Audit logging in this starter is application-event based, not an immutable trigger covering every possible database change. Production needs server-side audit triggers, append-only permissions, MFA, secure invitation/password-reset flow, rate limiting, backups, monitoring and independent penetration/security testing.
- Super Admin has global database visibility, but the Super Admin company-switching / consolidated all-company reporting interface is not fully built in this starter.
- GitHub Pages hosts frontend only; it is not a secure database or authentication server.
- Do not sell or use for live EPFO filings until the above gaps are closed and the system has passed legal, statutory, security and UAT review.
