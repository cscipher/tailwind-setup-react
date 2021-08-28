echo 'Setting up tailwind for your project...'

# installing tailwind
npm install -D tailwindcss@npm:@tailwindcss/postcss7-compat postcss@^7 autoprefixer@^9

# installing craco
npm install @craco/craco

# replacing react-scripts to craco
sed -i 's/react-scripts start/craco start/g' package.json
sed -i 's/react-scripts build/craco build/g' package.json
sed -i 's/react-scripts test/craco test/g' package.json

# creating craco.config.js and adding plugin data to it
touch craco.config.js
DATA="module.exports = {\nstyle: {\npostcss: {\nplugins: [\nrequire('tailwindcss'),\nrequire('autoprefixer'),\n],\n},\n},\n}\n"
echo $DATA > craco.config.js

# Generating tailwind config
npx tailwindcss-cli@latest init

# Replacing purge in tailwind.config.js
sed -i "s/purge : [],/purge: ['./src/**/*.{js,jsx,ts,tsx}', './public/index.html']," tailwind.config.js

# Relacing contents of index.css
NEW_CSS="@tailwind base;\n@tailwind components;\n@tailwind utilities;"
echo $NEW_CSS > src/index.css