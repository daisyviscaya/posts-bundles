# README

This project is made to compute the minimum bundle types required to accommodate an order.

This project is running on Ruby version 3.1.2 and Rails version 7.0.6.

To install it into your local:

* run `git clone https://github.com/daisyviscaya/posts-bundles.git` on your console

* Got to the root folder of the repository. Then, run `bundle` to install the ruby gems needed

* Go to the rails console by typing `rails c` on the root folder of the repository

* To run the main interactor that computes the bundles, run 
```
# Edit str_input variable for input
str_input = "10 IMG 15 FLAC 13 VID"

# Call this Interactor in the rails console
Bundles::Organizers::Calculate.call(
  bundles_input: str_input
);

```

It should print this output:
```
10 IMG -> $800
	 1 x 10 -> $800
----------
15 FLAC -> $1957.5
	 1 x 6 -> $810
	 1 x 9 -> $1147.5
----------
13 VID -> $2370
	 1 x 3 -> $570
	 2 x 5 -> $1800
----------
```

* Wrong/Invalid input should return an error message: 

```
# Edit str_input variable for input
str_input = "NOT_INT IMG"

context = Bundles::Organizers::Calculate.call(
  bundles_input: str_input
)

context.success?
=> false
context.failure?
=> true
context.error
=> "Invalid input format. Please try again."
```

* To check the unit tests, run `rspec` from the root folder. All test files are in `spec/` folder

* To check for lint errors, run `rubocop` from the root folder
