import React, { Component } from 'react';
import {
  AppRegistry,
  Text,
  View,
  Navigator,
  StyleSheet
  
} from 'react-native';

import NavigationBar from 'react-native-navbar';

import Accordion from 'react-native-collapsible/Accordion';
import CheckBox from 'react-native-checkbox';
//import CheckBox from 'react-native-check-box';
//import { CheckBox } from 'react-native-elements';

const SECTIONS = [
  {
    title: 'First',
    content: 'Now that we have a better understanding of flex direction, let’s review the alignment options that we have available. We will create a container that displays a message with a title, we will learn how to align this component.',
  },
  {
    title: 'Second',
    content: 'This tutorial is part of a series, in which we are learning all about the layout system in React Native. I recommend that you read the previous tutorial about how flexDirection works as we will continue using the same project that we created in the first tutorial.',
  },
  {
    title: 'Third',
    content: 'This tutorial is part of a series, in which we are learning all about the layout system in React Native. I recommend that you read the previous tutorial about how flexDirection works as we will continue using the same project that we created in the first tutorial.',
  },
  {
    title: 'Four',
    content: 'This tutorial is part of a series, in which we are learning all about the layout system in React Native. I recommend that you read the previous tutorial about how flexDirection works as we will continue using the same project that we created in the first tutorial.',
  }
];

export default class LevelDescriptorComponent extends Component {
  render() {
    return (
      <View tyle={styles.mainContainer}>

          <View style={styles.statusbar}>
              <NavigationBar
                title={titleConfig}
                rightButton={rightButtonConfig}
                leftButton={leftButtonConfig}
              />
        </View> 

        <View>
                <Text style={styles.messageBoxTitleText}>Level: Organization</Text>
                </View>
                <View>
                <Text style={styles.messageBoxTitleText}>Step 1:</Text>
        </View>
        
        <View style={styles.itmeContainer}>
            <Accordion
            sections={SECTIONS}
            renderHeader={this._renderHeader}
            renderContent={this._renderContent}
            />
          </View>

      </View>
    );
  }

  _renderHeader(section) {
    return (
      <View style={styles.header}>
        <Text style={styles.headerText}>{section.title}</Text>
      </View>
    );
  }

  _renderContent(section) {
    return (
      <View style={styles.content}>
        
          <View style={styles.checkboxitems}>
              <CheckBox 
                label='Apply'
                checked={false}
                //onChange={}
              />
              <CheckBox 
                label='Key Improvement Area'
                checked={false}
                //onChange={}
              />
              <CheckBox 
                label='NA'
                checked={false}
                //onChange={}
              />
          </View>
      </View>
    );
  }
}

  const rightButtonConfig = {
    title: 'Next',
    handler: () => alert('Go Next!'),
    
  };

  const leftButtonConfig = {
    title: 'Back',
    handler: () => alert('Go Back!'),
  };
  
  const titleConfig = {
    title: 'Organization',
  };

  var styles = StyleSheet.create({

    mainContainer:{
      flex:1,
      flexDirection: 'column',
      alignItems: 'center',
      justifyContent: 'center',

    },

    messageBox:{
      backgroundColor:'#ef553a',
      width:300,
      paddingTop:10,
      paddingBottom:20,
      paddingLeft:20,
      paddingRight:20, 
      borderRadius:10
    },

    statusbar: {
      backgroundColor:'#ef553a',
    },

    itmeContainer:{
      
    },

    header:{
      paddingLeft:10,
      
    },

    headerText:{
      fontSize: 30
    },

    contentText:{
      fontSize: 15
    },

    content:{
      flex:1,
      paddingTop:8,
      paddingBottom:10,
      paddingLeft:10,    
    },

    messageBoxTitleText:{
      fontSize:20,
      paddingLeft:10,
      paddingTop:10, 
      paddingBottom:10

     },

     checkboxitems:{
      flex:1,
      flexDirection: 'row',
      paddingTop:10,
     }

  });
  
AppRegistry.registerComponent('LevelDescriptorComponent', () => LevelDescriptorComponent);