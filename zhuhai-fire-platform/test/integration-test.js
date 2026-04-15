const axios = require('axios');

// 测试配置
const baseUrl = 'http://localhost:8080/api';

// 测试用例
const testCases = [
  {
    name: '用户登录',
    url: '/auth/login',
    method: 'POST',
    data: {
      username: 'admin',
      password: 'admin'
    },
    expectedStatus: 200
  },
  {
    name: '获取培训计划列表',
    url: '/training/list',
    method: 'GET',
    expectedStatus: 200
  },
  {
    name: '获取预案列表',
    url: '/plan/list',
    method: 'GET',
    expectedStatus: 200
  },
  {
    name: '获取想定作业列表',
    url: '/scenario/list',
    method: 'GET',
    expectedStatus: 200
  }
];

// 执行测试
async function runTests() {
  console.log('开始系统集成测试...');
  
  let token = '';
  
  for (const testCase of testCases) {
    console.log(`\n测试: ${testCase.name}`);
    console.log(`URL: ${testCase.url}`);
    
    try {
      const config = {
        method: testCase.method,
        url: `${baseUrl}${testCase.url}`,
        headers: {
          'Content-Type': 'application/json'
        }
      };
      
      if (testCase.data) {
        config.data = testCase.data;
      }
      
      if (token) {
        config.headers['Authorization'] = `Bearer ${token}`;
      }
      
      const response = await axios(config);
      
      if (response.status === testCase.expectedStatus) {
        console.log(`✓ 测试通过: 状态码 ${response.status}`);
        
        // 保存登录令牌
        if (testCase.name === '用户登录' && response.data.token) {
          token = response.data.token;
          console.log('✓ 获取到登录令牌');
        }
      } else {
        console.log(`✗ 测试失败: 状态码 ${response.status}，期望 ${testCase.expectedStatus}`);
      }
    } catch (error) {
      console.log(`✗ 测试失败: ${error.message}`);
    }
  }
  
  console.log('\n系统集成测试完成');
}

// 运行测试
runTests();