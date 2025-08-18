# setup.sh - Customisations Team
# Commands to install and configure phpBB
echo "[Codespaces] Customisations Team configuration..."

# Start MySQL
echo "[Codespaces] Start MySQL"
sudo service mysql start

# Start Apache
echo "[Codespaces] Start Apache"
sudo service apache2 start

# Add SSH key
# echo "[Codespaces] Add SSH key"
# echo "$SSH_KEY" > /home/vscode/.ssh/id_rsa && chmod 600 /home/vscode/.ssh/id_rsa

# Create a MySQL user to use
echo "[Codespaces] Create MySQL user"
sudo mysql -u root<<EOFMYSQL
    CREATE USER 'phpbb'@'localhost' IDENTIFIED BY 'phpbb';
    GRANT ALL PRIVILEGES ON *.* TO 'phpbb'@'localhost' WITH GRANT OPTION;
    CREATE DATABASE IF NOT EXISTS phpbb;
EOFMYSQL

# Symlink the webroot so it can be viewed
echo "[Codespaces] Create Symlink of webroot"
sudo rm -rf /var/www/html
sudo ln -s /workspaces/phpbb/phpBB /var/www/html

# Force the server URL to reflect the Codespace
# https://docs.github.com/en/codespaces/developing-in-a-codespace/default-environment-variables-for-your-codespace
if [ "$CODESPACES" = true ] ; then
    echo "[Codespaces] Set the phpBB server name using default environment variables"
    codespaces_url="${CODESPACE_NAME}-80.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
    sed -i "s/localhost/$codespaces_url/g" /workspaces/phpbb/.devcontainer/resources/phpbb-config.yml
fi

# Install phpBB
echo "[Codespaces] Run phpBB CLI installation"
cd /workspaces/phpbb/phpBB && composer install --no-interaction
sudo php /workspaces/phpbb/phpBB/install/phpbbcli.php install /workspaces/phpbb/.devcontainer/resources/phpbb-config.yml
rm -rf /workspaces/phpbb/phpBB/install

# Finished
echo "[Codespaces] phpBB (Customisation Team) installation completed"
