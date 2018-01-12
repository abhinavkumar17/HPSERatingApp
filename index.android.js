/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';

//import SplashScreen from './src/components/SplashScreen';
import LoginScreen from './src/components/LoginScreen';
import IntroScreen from './src/components/IntroScreen';
import LevelDescriptorComponent from './src/components/LevelDescriptorComponent';
import { Navigation } from 'react-native-navigation';

import {
  StackNavigator,
} from 'react-navigation';
//import IntroScreen from './IntroScreen';

const App = StackNavigator({
  Login : { screen: LoginScreen },
  Intro: { screen: IntroScreen },
});

export default class HPSERatingApp extends Component {
  render() {
    return (
      <LevelDescriptorComponent/>
    );
  }
}

AppRegistry.registerComponent('HPSERatingApp', () => HPSERatingApp);
