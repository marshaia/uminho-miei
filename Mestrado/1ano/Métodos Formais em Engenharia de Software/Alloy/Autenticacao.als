

sig Password {}
sig User {
	var password : set Password
}
var sig LoggedIn in User {}


// User Login
pred logIn [ u : User, p: Password ] {
  // guards
  u not in LoggedIn
  p in u.password
  // effects
  LoggedIn' = LoggedIn + u
  // frame condition
  all user : User | user.password' = user.password
}

// User Register
pred register[u : User , p: Password] {
  // guards
  historically no u.password
  u not in LoggedIn
  // effects
  u.password' = p
  LoggedIn' = LoggedIn + u
  // frame conditions
  all user : User - u | user.password' = user.password
}

// User LogOut
pred logOut [ u : User ] {
  // guards
  u in LoggedIn
  // effects
  LoggedIn' = LoggedIn - u
  // frame condition
  all user : User | user.password' = user.password
} 

// Delete User
pred delete [ u : User ] {
  // guards
  u in LoggedIn
  // effects
  LoggedIn' = LoggedIn - u
  no u.password'
  // frame condition
  all user : User - u | user.password' = user.password
}
 
// Change Password
pred changePass [u : User, p : Password] {
  // guards
  u in LoggedIn
  historically no p & u.password
  // effects
  u.password' = p  
  // frame conditions
  LoggedIn' = LoggedIn 
  all user : User - u | user.password' = user.password
}
 
pred stutter {
  password' = password 
  LoggedIn' = LoggedIn
}

pred behavior {
  no LoggedIn
  no password

  always {
    stutter or
    (some u : User , p: Password | register [u,p] or logIn[u,p] or changePass[u,p]) or
    (some u : User | logOut[u] or delete[u])
  }
}