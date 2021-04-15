#Task Solution

## Design Pattern

- I have used MVVM design pattern becuase it seprates UI from logic, seperate unit tests are easier and code is event driven.

## Dependcies

- No external Library is used.

## Project Structure

- Project is divided into respective folders as the folder name describes.
- There are commons and helper folder which have global app constans and common utility functions.

## Logic

- By default, shows for search query "girl" are shown.
- On cancel button press, no action is implemented as it depends upon requirements.
- I have used backgroud image for table view in case there are no shows found which stays if you press cancel button. I would have implmeneted an animated view to show the message on top or bottom but due to time and simplicity, I avoided.
- Image View is extended to handle download and cache image from URL
- Search bar is shown as "on scroll" on purpose.
- all views are added programmatically using autolayouts constraints.
- Data is fetched from API service assuming URL is valid. In case of invalud URL error is shown. 
- Simple Loader is shown to save time.
- View Model handles all the logic and notifies the view controller whenever data is fetched successfully or if there is an error. 

## Testing 

- I have included basic unit and UI tests as well.
