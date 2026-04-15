# 三维模型建设说明

## 模型标准

### 单位外观建模标准
- **LOD级别**: LOD4（符合城市三维建模技术规范CJJ/T157-2010）
- **模型格式**: 支持 .obj, .gltf, .glb 格式
- **数据量**: 每个单位模型数据量小于2MB
- **纹理要求**: 分辨率适中，确保渲染效果清晰

### 单位内部建模标准
- **CIM级别**: CIM 16-17级（符合住房和城乡建设部CIM分级标准）
- **模型精度**: 详细到房间、楼梯、消防设施等内部结构

### 车辆/人员/器材/设施模型标准
- **模型格式**: 支持 .obj, .gltf, .glb 格式
- **数据量**: 每个模型数据量小于500KB
- **细节要求**: 具备基本的几何细节和纹理

## 目录结构

```
models/
├── units/          # 重点单位三维模型
│   ├── unit1/      # 单位1
│   │   ├── exterior/  # 外观模型
│   │   └── interior/  # 内部模型
│   └── unit2/      # 单位2
├── vehicles/       # 消防车辆模型
├── personnel/      # 人员模型
├── equipment/      # 器材模型
└── facilities/     # 设施模型
```

## 模型命名规范

- **单位模型**: `unit_{单位代码}_{模型类型}.{格式}`
  示例: `unit_001_exterior.glb`, `unit_001_interior.glb`

- **车辆模型**: `vehicle_{车型代码}.{格式}`
  示例: `vehicle_fire_truck.glb`

- **人员模型**: `personnel_{角色代码}.{格式}`
  示例: `personnel_firefighter.glb`

- **器材模型**: `equipment_{器材代码}.{格式}`
  示例: `equipment_hose.glb`

- **设施模型**: `facility_{设施代码}.{格式}`
  示例: `facility_hydrant.glb`

## 模型导入流程

1. **准备模型**: 按照上述标准和命名规范准备模型文件
2. **上传模型**: 将模型文件上传到对应的目录
3. **注册模型**: 在系统中注册模型信息，包括模型名称、类型、路径等
4. **验证模型**: 验证模型是否能正常加载和渲染

## 模型使用方法

### 在前端系统中使用

```javascript
// 加载单位外观模型
const model = new Cesium.Model({
  url: '/models/units/unit_001_exterior.glb',
  position: Cesium.Cartesian3.fromDegrees(longitude, latitude, height),
  scale: 1.0
});

// 添加到场景
viewer.scene.primitives.add(model);
```

### 在移动端App中使用

```javascript
// 使用Three.js加载模型
const loader = new THREE.GLTFLoader();
loader.load(
  'https://api.example.com/models/units/unit_001_exterior.glb',
  (gltf) => {
    scene.add(gltf.scene);
  }
);
```

## 模型维护

- **定期更新**: 根据实际情况定期更新模型
- **版本管理**: 对模型进行版本管理，记录变更历史
- **性能优化**: 定期对模型进行轻量化处理，确保加载和渲染性能

## 注意事项

- 确保模型数据安全，避免泄露敏感信息
- 遵守相关法律法规，确保模型使用合法
- 定期备份模型数据，防止数据丢失