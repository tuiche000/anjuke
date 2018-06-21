const form_datas = {
  'house': [
    { type: 'text', name: 'title', title: '标题' },
    { type: 'text', name: 'sub_title', title: '副标题' },
    { type: 'text', name: 'postion_main', title: '主位置' },
    { type: 'text', name: 'postion_secound', title: '副位置' },
    { type: 'number', name: 'ave_price', title: '均价' },
    { type: 'number', name: 'area_min', title: '最小面积' },
    { type: 'number', name: 'area_max', title: '最大面积' },
    { type: 'tel', name: 'tel', title: '电话' },
    { type: 'date', name: 'sale_time', title: '开盘日期' },
    { type: 'date', name: 'submit_time', title: '交房日期' },
    { type: 'text', name: 'building_type', title: '建筑类型' },
    { type: 'file', name: 'main_img', title: '大图' },
    { type: 'file', name: 'img', title: '小图(多选)', multiple: true },
    { type: 'text', name: 'property_types', title: '户型' },
    { type: 'file', name: 'property_img', title: '户型图' },
    { type: 'text', name: 'location', title: '小区坐标' }
  ],
  'ad': [
    { type: 'number', name: 'type', title: '类型' },
    { type: 'text', name: 'title', title: '标题' },
    { type: 'url', name: 'link', title: '网址' },
    { type: 'file', name: 'img', title: '图片' },
    { type: 'data', name: 'expires', title: '有效期' },
    { type: 'number', name: 'n_order', title: '序号' }
  ],
  'broker': [
    { type: 'text', name: 'title', title: '姓名' },
    { type: 'file', name: 'img', title: '头像' }
  ],
  'link': [
    { type: 'number', name: 'type', title: '类型' },
    { type: 'text', name: 'title', title: '标题' },
    { type: 'url', name: 'link', title: '网址' },
    { type: 'number', name: 'n_order', title: '序号' },
    { type: 'date', name: 'expires', title: '有效期' }
  ]
}