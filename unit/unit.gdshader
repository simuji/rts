shader_type canvas_item;

// ===== 色系替换核心参数 =====
// 源色系的中心色相（0=红, 0.166=黄, 0.333=绿, 0.5=青, 0.666=蓝, 0.833=紫, 1=红）
uniform float source_hue_center  = 0.0; // 默认红色系
// 源色系的匹配范围（0=仅中心色相, 0.5=覆盖半个色轮）
uniform float source_hue_range = 0.01; // 匹配红色系±10%范围
// 目标色系的中心色相（替换后的主色系）
uniform float target_hue_center = 0.666; // 默认蓝色系
// 是否保留原颜色的饱和度和亮度（建议开启）
uniform bool preserve_saturation_brightness = true;
// 是否保留原透明度
uniform bool preserve_alpha = true;

// RGB转HSV（Shader兼容版，处理色相连环特性）
vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0/3.0, 2.0/3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y)/(6.0*d + e)), d/(q.x + e), q.x);
}

// HSV转RGB（还原颜色用）
vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0/3.0, 1.0/3.0, 3.0);
    vec3 p = abs(fract(c.x + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void fragment() {
    // 1. 获取原始像素颜色
    vec4 original_color = texture(TEXTURE, UV);
    vec3 original_rgb = original_color.rgb;
    
    // 2. 转换为HSV空间，分析原始色相
    vec3 original_hsv = rgb2hsv(original_rgb);
    float original_hue = original_hsv.x;
    
    // 3. 计算原始色相与源色系的距离（处理色相连环，比如0.99和0.01的距离是0.02）
    float hue_diff = abs(original_hue - source_hue_center);
    hue_diff = min(hue_diff, 1.0 - hue_diff); // 色轮是环形，取最短距离
    
    // 4. 判断是否在源色系范围内，满足则替换色系
    if (hue_diff <= source_hue_range) {
        vec3 new_hsv = original_hsv;
        
        // 替换色相为目标色系（核心逻辑）
        new_hsv.x = target_hue_center;
        
        // 可选：保留原饱和度和亮度（仅改色系，不改深浅/鲜艳度）
        if (!preserve_saturation_brightness) {
            new_hsv.y = 1.0; // 强制最高饱和度
            new_hsv.z = 1.0; // 强制最高亮度
        }
        
        // 5. 转换回RGB颜色
        vec3 new_rgb = hsv2rgb(new_hsv);
        vec4 new_color = vec4(new_rgb, original_color.a);
        
        // 6. 保留原透明度（可选）
        if (preserve_alpha) {
            new_color.a = original_color.a;
        }
        
        COLOR = new_color;
    } else {
        // 不在源色系范围内，保留原颜色
        COLOR = original_color;
    }
}