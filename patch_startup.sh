#!/bin/sh
# Patch Postiz Next.js middleware to handle Google OAuth callbacks
# Bug: proxy.ts checks ['google','settings'] but Google redirects to /integrations/social/youtube
sed -i 's/\["google","settings"\]/["google","settings","youtube"]/' \
  "/app/apps/frontend/.next/server/chunks/[root-of-the-server]__0-e5mkf._.js"
sed -i 's/"settings"===e?process.env.POSTIZ_GENERIC_OAUTH?"generic":"github":e/"settings"===e?process.env.POSTIZ_GENERIC_OAUTH?"generic":"github":"youtube"===e?"google":e/' \
  "/app/apps/frontend/.next/server/chunks/[root-of-the-server]__0-e5mkf._.js"

# Patch LinkedIn provider scopes (remove deprecated r_basicprofile and org scopes)
sed -i "s/'r_basicprofile',//; s/'rw_organization_admin',//; s/'w_organization_social',//; s/'r_organization_social',//" \
  /app/apps/backend/dist/libraries/nestjs-libraries/src/integrations/social/linkedin.provider.js
sed -i "s/'r_basicprofile',//; s/'rw_organization_admin',//; s/'w_organization_social',//; s/'r_organization_social',//" \
  /app/apps/backend/dist/libraries/nestjs-libraries/src/integrations/social/linkedin.page.provider.js
sed -i "s/'r_basicprofile',//; s/'rw_organization_admin',//; s/'w_organization_social',//; s/'r_organization_social',//" \
  /app/apps/orchestrator/dist/libraries/nestjs-libraries/src/integrations/social/linkedin.provider.js
sed -i "s/'r_basicprofile',//; s/'rw_organization_admin',//; s/'w_organization_social',//; s/'r_organization_social',//" \
  /app/apps/orchestrator/dist/libraries/nestjs-libraries/src/integrations/social/linkedin.page.provider.js

# Start Postiz services
nginx && pnpm run pm2
