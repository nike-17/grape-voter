/root/.bash_profile 

cd /www/api.putin.io/current && RACK_ENV=production bundle exec rake data:generate_all
cd /www/api.putin.io/current && RACK_ENV=production bundle exec rake data:generate_top
cd /www/api.putin.io/current && RACK_ENV=production bundle exec rake data:generate_sitemap
cd /www/api.putin.io/current && RACK_ENV=production bundle exec rake data:generate_candidates