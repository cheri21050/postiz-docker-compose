#!/bin/sh
# Patch Postiz Next.js middleware to handle Google OAuth callbacks
# Bug: proxy.ts checks ['google','settings'] but Google redirects to /integrations/social/youtube
sed -i 's/\["google","settings"\]/["google","settings","youtube"]/' \
  "/app/apps/frontend/.next/server/chunks/[root-of-the-server]__0-e5mkf._.js"
sed -i 's/"settings"===e?process.env.POSTIZ_GENERIC_OAUTH?"generic":"github":e/"settings"===e?process.env.POSTIZ_GENERIC_OAUTH?"generic":"github":"youtube"===e?"google":e/' \
  "/app/apps/frontend/.next/server/chunks/[root-of-the-server]__0-e5mkf._.js"

# Start Postiz services
nginx && pnpm run pm2
