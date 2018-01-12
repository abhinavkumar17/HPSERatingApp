import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';

import SplashScreen from "rn-splash-screen";

export default class SplashScreen1 extends Component {
  render() {
    return (
      <View>
        <Text>Hello</Text>
    </View>
    );
  }

  componentDidMount() {
    // do stuff while splash screen is shown
      // After having done stuff (such as async tasks) hide the splash screen
      SplashScreen.hide();
  }
}

AppRegistry.registerComponent('SplashScreen1', () => SplashScreen1);