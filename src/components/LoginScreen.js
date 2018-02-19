import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';

import Login from 'react-native-simple-login';

import {
  StackNavigator,
} from 'react-navigation';

export default class LoginScreen extends Component {
  static navigationOptions = {
    title: 'Login',
  };
  render() {
    
    return (
      
       <Login
          onLogin={onLogin}
          onResetPassword={onResetPassword}/>
    );
  }
}

onLogin = (email, password) => {
   const navigate  = this.props.navigation;
    console.log(email, password) // user credentials
    navigate('Intro');
}
  
onResetPassword = (email) => {
    console.log(email)
}

onResetPassword1 = (email) => {
  console.log(email)
}


AppRegistry.registerComponent('LoginScreen', () => LoginScreen);