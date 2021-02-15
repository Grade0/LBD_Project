# LabBD
"Database Laboratory" Class Team Project - University of Pisa

**Click [[here](/ProgettoLBD_IT.pdf)] for Italian version**

**Team:** Betola Gianmarco, Catania Saverio, Chen Davide, Li Malio, Pardini Luca, Stasula Ruslan

## Una Cervecita Fresca  

Home brewing is an activity that receives increasing attention from enthusiasts. 
Every amateur brewer owns equipment for the small-scale brewing process (kettles, fermenters, pipes, etc.) with a certain maximum fermentation capacity: the number of liters that the equipment is able to manage in a single "batch". Brewing also requires ingredients, the actual amounts of which vary from recipe to recipe, these are various types of malt, hops, yeast and sugar (and, of course, water).

Brewers like to register their recipes for future reference and keep an up-to-date list of available ingredients to make purchases before the next production.

The aim of this project is to develop an application for home brewers that allows them to maintain a list of recipes and adapt existing ones. The application shall also:
* maintain a list of available ingredients;
* update that list after a production cycle and when new ingredients are purchased;
* produce shopping lists for the next batch;

### Project goal
Creation of an ORACLE Database complete with analysis, data design and implementation of procedures and interface for the web application 'Una Cervecita Fresca'.

### Project description
“Una cervecita fresca” is an application that allows amateur brewers to maintain an organized database of their beer recipes. The application allows users to create, store and edit recipes, and then delete them, if the user wishes to do so. The application is intended for brewers of all methodology: all-grain, extract and mixed, and therefore all recipes are for these types of beers.

Each domestic brewery has specific equipment, the characteristics of which lead to a particular "batch size": the maximum number of liters that can be produced in a single production. In addition to water, the recipes include:
* malts
* hop
* yeasts
* sugars
* additives

While beer producers prefer to create recipes referring to concrete values, such as kilograms of a particular malt or grams of a particular hops, The application must store these recipes in an "absolute" measure, which allows a direct conversion of the recipe when the equipment, and consequently the batch size, is different. For example, one option is to express the amount of malt as a percentage of the total and to use grams per litre of mixture (mash) for hops.

In addition to the recipes, the application must keep the instances of the recipe, ie single productions based on a recipe; these instances can be accompanied by notes to refer to issues that may affect the resulting beer, notes that brewers would like to remain memorized. A particular type of note is the tasting notes, which allow brewers to keep track of opinions about a beer in a given batch. A particular type of note is the tasting notes, which allow brewers to keep track of opinions about a beer in a given batch. 

In addition to these more traditional features, the application "Una cervecita fresca", maintains a list of available ingredients. This allows the brewers to have the list of missing ingredients for the next production. 
A recipe instance, i.e. a beer production, should allow users to update the list of available ingredients by subtracting the used ingredients from the available ones.

It will also be possible for brewers to sell brewed beer. **The application must offer a web interface for booking and selling.** A registered customer can reserve a batch of beer in production, or part of it. When the batch has been produced, the brewer can confirm the reservations and proceed with the sale or, if he is not satisfied with the product, cancel them, so as not to damage his good name. Unreserved beer can be offered for sale and bought by registered users.

### Application goal
The system must implement the functionalities described above, i.e. creation, modification and deletion of recipes, creation of recipe instances (beers), support for beer notes, control of available ingredients, production support with alarms, sales support.
