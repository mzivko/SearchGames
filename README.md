# RAWG API Game Search iOS App

### This iOS application allows users to choose their favorite video game genres and view a list of games related to the selected genres, utilizing the RAWG API.

## Installation

To run this application, you need to have Xcode installed on your Mac computer. You can then download or clone the repository to your local machine.

1. Clone the repository to your local machine using the command:
2. Run the application by clicking on the "Play" button in the top left corner of Xcode, or by pressing the Command + R key.

## Usage

When the application loads, you will be taken to the "Genres" screen, where you can select the video game genres that you are interested in. You can select as many genres as you like by tapping on the corresponding genre cells.

Once you have selected your genres, click the "Done" button in the top right corner of the screen to save your selections and view the game list screen.

On the "Games" screen, you will see a list of video games related to your selected genres. You can tap on any game cell to view more information about the game.

## Technical Details

This application was built using the following technologies:

    Xcode 14.2
    Swift 5.7
    RAWG API

The RAWG API is used to fetch video game data, including the list of available genres and games related to each genre. The data is retrieved using the URLSession and Codable protocols.

The application is organized into two main screens:

    Genres screen: Allows users to select their favorite genres.
    Games screen: Displays a list of games related to the selected genres.

The user's selected genres are saved to the device's UserDefaults so that they can be retrieved when the application is launched again.
Credits

This application was created by Marko Zivko for interivew purposes only. The RAWG API was used to retrieve video game data. Any logos or trademarks used in the application belong to their respective owners.
