# README

Package is not fully tested yet and performance can still be improved! Only use for testing purposes.

This package contains functions to create a set of 57 "Dobble" or "Spot it!" cards, containing 8 symbols each.

The main function enables the user to transform a folder with 57 images into a set of Dobble cards.
Another function enables to arrange the cards on DINA4 sheets for easy printing.

The algorithm used to generate the cards was taken from a [Math Stackexchange conversation](https://math.stackexchange.com/questions/1303497/what-is-the-algorithm-to-generate-the-cards-in-the-game-dobble-known-as-spo) on the topic. 

The cards are generated using the [Magick](https://github.com/ropensci/magick) and [Circlize](https://jokergoo.github.io/circlize_book/book/) packages.


