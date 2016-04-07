**Notice**: As of 4/1/2016 Imgur has discontinued support for their legacy API, and Imgyazo was updated. As a result, a new version of Imgyazo [is available for all platforms](https://github.com/vgmoose/Imgyazo/releases/tag/v1.2).

## Imgyazo
Gyazo that uploads to Imgur instead.


### Instructions
Identical to regular Gyazo: just click it and select the portion of the screen you want captured. It is then uploaded to Imgur, and copied to the clipboard. It will also open in the browser in front of you.

#### Bonus stuff
All images that are uploaded are logged to "~/Documents/imgyazo.html" file for quick reference. The deletion links are also logged, so that way you can delete them as well. Still working on making this look pretty, but for now it's funtionality over beauty.

#### Super Bonus stuff:
The Mac version of Gyazo writes all images to ~/Screenshots and doesn't delete them locally. The filename will be the same as the built-in screenshot tool (it literally uses the same function). Windows and Linux use a temporary folder and delete the image locally right after.

### Additional information:
The Mac and Linux versions can have the following Ruby scripts edited to customize directories and such in:
Mac: Imgyazo.app/Contents/Resources/script
Linux: src/gyazo.rb

