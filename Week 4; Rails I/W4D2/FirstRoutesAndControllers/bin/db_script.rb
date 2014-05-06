User.new({username: "Ash Ketchum"}).save
User.new({username: "Misty"}).save
User.new({username: "Brock"}).save
User.new({username: "Jesse"}).save
User.new({username: "James"}).save

Contact.new({name: "Pikachu", email: "pika@pika.com", user_id: 1}).save
Contact.new({name: "Squirtle", email: "squirt@pika.com", user_id: 1}).save
Contact.new({name: "Jigglypuff", email: "sing_song45@gmail.com", user_id: 2}).save
Contact.new({name: "Meowth", email: "bettathanmew@teamrocket.com", user_id: 5}).save
Contact.new({name: "Snorlax", email: "zzz@pika.com", user_id: 1}).save

ContactShare.new({contact_id: 1, user_id: 4}).save
ContactShare.new({contact_id: 2, user_id: 2}).save
ContactShare.new({contact_id: 3, user_id: 3}).save
ContactShare.new({contact_id: 5, user_id: 3}).save

Comment.new({body: "Ash, you are bad and you should feel bad", commentable_id: 1, commentable_type: "User", commenter_id: 5}).save
Comment.new({body: "Sup misty? ;)", commentable_id: 2, commentable_type: "User", commenter_id: 3}).save
Comment.new({body: "Laziest pokemon I have ever worked with.  Would not recommend. **", commentable_id: 5, commentable_type: "Contact", commenter_id: 1}).save
Comment.new({body: "Zzzzzzzz",  commentable_id: 3, commentable_type: "Contact", commenter_id: 5}).save