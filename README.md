# Diabetes Helper

An intuitive app to help users manage their diabetes, developed in Android Studio using Flutter and Dart.

## Information

This project is owned and published by Saluki Corporation. Please see the license file for further details about usage permissions.

Any questions about this project or the app that is built from it should be directed to support@salukicorporation.com or relayed to our Discord support team. (See salukicorporation.com for further details).

## Todo

Strikethrough when complete


**Improve logbook:**
- <strike>Show time as well as date</strike> 
- <strike> Allow user to set a custom date and time (on new and edit)</strike>
- <strike>Let users search entries and sort by certain fields</strike>
- <strike>Refresh entries when a new one is created (to make it appear straight away)</strike>
- <strike>Improve the entry creation system (activity will have a dropdown, with options like "Breakfast", "Lunch", "Dinner", "Walking", "Cycling" and a custom one)</strike>
- <strike>Improve the data export system (after exporting the file, give the user an option to share it)</strike>
- Improve the UI for the logbook
- Add a ketone value (let the user specify their ketone level, this is a number)

**New API:**
- <strike>Use the new spoonacular API (may switch again if it doesn't work out), looking for a good API with lots of food types and meals.</strike>

**Search:**
- <strike>Display some information by default instead of infinitely showing the loading icon, maybe just show a few random foods?</strike>
- Allow the user to add their own custom foods and save this to a local database
- Allow user to "Add to meal" foods after entering a weight and then calculate the total carbs of all items in the meal at once
- Allow user to save a meal preset and then check or edit it at any time
- A button for users to calculate insulin quickly on any food or meal, they just hit the meal, choose the preset (see Insulin Calculator) and then it will say how much insulin they need. If it is not a meal, then get them to specify the weight of the product and then calculate the carbs and insulin dose at the same time.
- If possible, automatically enter an average portion size weight of each food when you choose a food on the search.
- Add a placeholder image to be displayed if there is no image for the food item. Make sure this image does not obviously contain any foods, so maybe something like an empty trolley.
- Add a "No results found" page instead of loading infinitely.
- Have a set of 10-15 default foods that display when you visit the search page, instead of just apples. Saluki can provide these, message him.

**Add a menu icon in the top left** (like this: https://zhijiaprofessionalcontext.files.wordpress.com/2014/04/logotype17.jpg)
- "About" option which pulls up a popup with a bit of about info
- Settings menu (Clear logbook, clear custom foods, clear exported files, clear meals, reset app (delete all data, gdpr), rate app, contact support, export all data (gdpr), import data etc)

**Insulin Calculator:**
- Get users to configure their settings on first use
- Allow users to change their settings in the settings menu
- Users can select their preset (eg, Breakfast, Lunch, Dinner, Snack) and then enter their carb intake, the system will output how many units they need.
- After calculating insulin, give an option to add to the logbook straight away. Make this work for meals and foods as well.

What settings do users need to set?:

Insulin to carb ratios for each preset they create,

So an example would be 1:15 (1 unit for every 15 grams of carbs they consume).
This may be different for different meals and activities, so let users set their own presets and define the ratios for it.

For calculating insulin:

Take carbs and divide by ratio equals units of insulin.
