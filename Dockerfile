FROM node:lts

# Install package
RUN set -x \
&& apt-get update \
&& apt-get install gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget --yes --fix-missing \
&& wget --no-check-certificate https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
&& dpkg -i google-chrome-stable_current_amd64.deb || apt -y -f install \
&& rm google-chrome-stable_current_amd64.deb \
&& apt autoremove --yes

# Run on port 8080
EXPOSE 8080

# Clone Repo
RUN git clone -b master https://github.com/aidilaryanto/projectdils-wa /home/projectdils/

# Copy session file for permanent login
COPY ProjectDils.data.json /home/projectdils/ProjectDils.data.json

# Set Wworking Directory
WORKDIR /home/projectdils/

# Install Modules Dependencies
RUN npm install
RUN npm install --only=dev --ignore-scripts

CMD ["npm", "start"]
