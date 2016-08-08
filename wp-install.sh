#!/bin/bash -e

echo "================================================================="
echo "WP Installer"
echo ""
echo "It will install WP latest version together with:"
echo ""
echo "- WPML"
echo "- WPML ST"
echo "- WPML TM"
echo "- WPML MT"
echo "- WPML CMS Nav"
echo "- WPML SL"
echo ""
echo "WPML plugins will be copied from wpml.dev plugins folder."
echo ""
echo "WP user: adriano"
echo "WP pass: 123456"
echo "================================================================="
echo ""
echo "Domain: (e.g: wpml.dev)"

read -e domain

wp_path="/Applications/MAMP/htdocs/$domain"

sudo -- sh -c "echo 127.0.0.1       $domain >> /private/etc/hosts"

cd /Applications/MAMP/htdocs/

mkdir $domain

wp core download --path=$wp_path

wp core config --dbname=$domain --dbuser=root --dbpass=root --path=$wp_path

wp db create --path=$wp_path

wp core install --url="http://$domain" --title="$domain" --admin_user="adriano" --admin_password="123456" --admin_email="adrianokta@gmail.com" --path=$wp_path

cp -R /Applications/MAMP/htdocs/wpml.dev/wp-content/plugins/ $wp_path/wp-content/plugins/

cd $wp_path

wp plugin activate sitepress-multilingual-cms --path=$wp_path
wp plugin activate wpml-string-translation --path=$wp_path
wp plugin activate wpml-translation-management --path=$wp_path
wp plugin activate wpml-media-translation --path=$wp_path
wp plugin activate wpml-cms-nav --path=$wp_path
wp plugin activate wpml-sticky-links --path=$wp_path

echo "================================================================="
echo "Installation is complete."
echo "================================================================="
