import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import LoginScreen from './src/screens/LoginScreen';
import MainScreen from './src/screens/MainScreen';
import TrainingScreen from './src/screens/TrainingScreen';
import ExamScreen from './src/screens/ExamScreen';
import ScheduleScreen from './src/screens/ScheduleScreen';
import PanoramaScreen from './src/screens/PanoramaScreen';
import FacilityScreen from './src/screens/FacilityScreen';
import KeyPositionScreen from './src/screens/KeyPositionScreen';
import StatisticsScreen from './src/screens/StatisticsScreen';

const Stack = createStackNavigator();

export default function App() {
  return (
    <SafeAreaProvider>
      <NavigationContainer>
        <Stack.Navigator initialRouteName="Login">
          <Stack.Screen name="Login" component={LoginScreen} options={{ headerShown: false }} />
          <Stack.Screen name="Main" component={MainScreen} options={{ title: '珠海消防数字化平台' }} />
          <Stack.Screen name="Training" component={TrainingScreen} options={{ title: '培训管理' }} />
          <Stack.Screen name="Exam" component={ExamScreen} options={{ title: '考核管理' }} />
          <Stack.Screen name="Schedule" component={ScheduleScreen} options={{ title: '日程管理' }} />
          <Stack.Screen name="Panorama" component={PanoramaScreen} options={{ title: '全景查看' }} />
          <Stack.Screen name="Facility" component={FacilityScreen} options={{ title: '设施采集' }} />
          <Stack.Screen name="KeyPosition" component={KeyPositionScreen} options={{ title: '重点部位' }} />
          <Stack.Screen name="Statistics" component={StatisticsScreen} options={{ title: '统计分析' }} />
        </Stack.Navigator>
      </NavigationContainer>
    </SafeAreaProvider>
  );
}