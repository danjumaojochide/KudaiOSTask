This project contains fetching a list of transactions from a url. MVVM architecture was used, by separating the model, view model and views. 
I also implemented abstraction by using protocol for the transaction service and having a class that implemented that protocol. I then injected the protocol into the view model to ease testing as i can then easily have a mock transaction service to test with.
I used the init(decoder:) for the transactionType enum to handle instances where an invalid type like an empty string is returned. So i just default such cases to unknown.
I also used CodingKeys enum to handle decoding to Transaction type. This gives me the flexibilty to handle each decoded property dynamically. \nFor example handling the amount property, and setting the value based on whether it is a string or a double, and i just default it to zero if its a different type entirely, which is not expected from the requirements of the task.
I use combine to publish changes to my UI when the fetch is completed and i handle the success and error cases.
I implemented a search feature as required for user to filter list of transactions by name. I simply used a UISearchController and placed it in the navigation Bar. \nParticularly to achieve this and have a title for my view controller be displayed, I embedded the viewController in a Navigation Controller.
I didn't want the screen to just be blank while transactions are being fetched so I used an activity indicator to show that a task is actve.
I also have an error alert incase the API call fails or something else goes wrong. The alert can either be simply dismissed or you can retry fetching the transactions.
I set the cell's background color based on transaction type, and had reversal be a lighter shade of green because it is still a credit in a way. Debit is red and unknown types are greyed.
Here's a video of the application when Transactions are fetched without errors and when i alter the url to make the request fail

https://github.com/user-attachments/assets/ff306a11-c6db-414b-96a4-306f5566525a

https://github.com/user-attachments/assets/3063295d-bf87-4dd2-bad2-04ed8d6d1647

