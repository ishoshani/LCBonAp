breakfast = Meal.create(name: "Breakfast")
lunch = Meal.create(name: "Lunch")
dinner = Meal.create(name: "Dinner")

breakfast.items.create( station:      "Morning Favorites",
                        title:        "Eggs, bacon, pancakes",
                        description:  "",
                        votes:        0 )
breakfast.items.create( station:      "Grill",
                        title:        "Omelettes",
                        description:  "With grilled peppers, ham, and cheese.",
                        votes:        0 )
breakfast.items.create( station:      "Continental",
                        title:        "Cereal",
                        description:  "Corn flakes, Cocoa Puffs, Rice Crispies.",
                        votes:        0 )
lunch.items.create( station:      "Knife and Fork",
                    title:        "Peppercorn Steak",
                    description:  "Medium-rare peppercorn steak with mashed potatoes, broccoli, and bread rolls.",
                    votes:        0 )
lunch.items.create( station:      "Spice Trail",
                    title:        "Cuban rice and beans",
                    description:  "Cuban-style rice and beans with squash and kale.",
                    votes:        0 )
lunch.items.create( station:      "Grill",
                    title:        "Hot dogs",
                    description:  "Beef or turkey hotdogs, chips, and salad.",
                    votes:        0 )
dinner.items.create( station:     "Grill",
                    title:        "All-American burgers",
                    description:  "Grassfed beef or tofu burgers with sweet potato fries.",
                    votes:        0 )
dinner.items.create( station:     "Comfort",
                    title:        "Pizza",
                    description:  "Italian sausage and fetta cheese pizza with tomato sauce and garlic bread.",
                    votes:        0 )