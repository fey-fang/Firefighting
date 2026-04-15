import React from 'react';
import { StyleSheet, View, Text, TouchableOpacity, ScrollView, Image } from 'react-native';

const MainScreen = ({ navigation }) => {
  const menuItems = [
    {
      id: 'training',
      title: '培训管理',
      icon: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=培训管理图标&image_size=square',
      screen: 'Training'
    },
    {
      id: 'exam',
      title: '考核管理',
      icon: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=考核管理图标&image_size=square',
      screen: 'Exam'
    },
    {
      id: 'schedule',
      title: '日程管理',
      icon: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=日程管理图标&image_size=square',
      screen: 'Schedule'
    },
    {
      id: 'panorama',
      title: '全景查看',
      icon: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=全景查看图标&image_size=square',
      screen: 'Panorama'
    },
    {
      id: 'facility',
      title: '设施采集',
      icon: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=设施采集图标&image_size=square',
      screen: 'Facility'
    },
    {
      id: 'keyPosition',
      title: '重点部位',
      icon: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=重点部位图标&image_size=square',
      screen: 'KeyPosition'
    },
    {
      id: 'statistics',
      title: '统计分析',
      icon: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=统计分析图标&image_size=square',
      screen: 'Statistics'
    }
  ];

  return (
    <ScrollView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.welcomeText}>欢迎使用珠海消防数字化平台</Text>
        <Text style={styles.subText}>请选择您需要的功能</Text>
      </View>

      <View style={styles.menuContainer}>
        {menuItems.map((item) => (
          <TouchableOpacity
            key={item.id}
            style={styles.menuItem}
            onPress={() => navigation.navigate(item.screen)}
          >
            <Image source={{ uri: item.icon }} style={styles.menuIcon} />
            <Text style={styles.menuTitle}>{item.title}</Text>
          </TouchableOpacity>
        ))}
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  header: {
    padding: 20,
    backgroundColor: '#1E88E5',
    borderBottomLeftRadius: 20,
    borderBottomRightRadius: 20,
  },
  welcomeText: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#fff',
    marginBottom: 10,
  },
  subText: {
    fontSize: 16,
    color: '#E3F2FD',
  },
  menuContainer: {
    padding: 20,
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  menuItem: {
    width: '30%',
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 15,
    alignItems: 'center',
    marginBottom: 20,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.1,
    shadowRadius: 3.84,
    elevation: 5,
  },
  menuIcon: {
    width: 50,
    height: 50,
    marginBottom: 10,
  },
  menuTitle: {
    fontSize: 14,
    fontWeight: '500',
    color: '#333',
  },
});

export default MainScreen;