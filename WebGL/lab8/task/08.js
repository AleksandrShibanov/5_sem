// 04.js

"use strict";

// Vertex shader program
const VSHADER_SOURCE =
    '#version 100\n' +
    'attribute vec4 a_Position;\n' +
    'attribute float a_PointSize;\n' +
    // 'uniform mat4 u_ModelMatrix;\n' +
    'uniform mat4 u_ViewMatrix;\n' +
    'uniform mat4 u_ProjectionMatrix;\n' +
    'uniform mat4 u_PerspectiveMatrix;\n' +
    'uniform vec3 u_lightSource;\n' +
    'uniform vec3 u_kD;\n' +
    'uniform vec3 u_ReverseLightDirection;\n' +
    'uniform vec4 u_FragColor;\n' +
    'attribute vec3 a_Normal;' +
    'vec3 DirectionToLight;\n' +
    'varying vec3 v_Color;\n' +
    'void main() {\n' +
    '  gl_Position = u_PerspectiveMatrix*u_ProjectionMatrix*u_ViewMatrix*a_Position;\n' +
    '  gl_PointSize = a_PointSize;\n' +
    '  DirectionToLight = normalize(u_lightSource - a_Position.xyz);\n' +
    'float light = dot(a_Normal, u_ReverseLightDirection);\n' +
    // 'light = dot(normal, v_DirectionToLight);' +
    'if(light < 0.0) light = 0.0;\n' +
    'v_Color = light*u_FragColor.rgb;\n' +
    // Умножим только цвет (без прозрачности) на значение
    // освещения
    'v_Color.r *= u_kD[0];\n' +
    'v_Color.g *= u_kD[1];\n' +
    'v_Color.b *= u_kD[2];\n' +
    '}\n';

// Fragment shader program
const FSHADER_SOURCE =
    'precision mediump float;\n' +
    // 'uniform float u_Width;\n' +
    // 'uniform float u_Height;\n' +
    'vec4 Position;\n' +
    'varying vec3 v_Color;\n' +
    'void main() {\n' +
    'gl_FragColor.rgb = v_Color;\n' +
    'gl_FragColor.a = 1.0;\n' +
    '}\n';

function main() {
    // Retrieve <canvas> element
    const canvas = document.getElementById('webgl');

    // Get the rendering context for WebGL
    const gl = getWebGLContext(canvas);
    if (!gl) {
        console.log('Failed to get the rendering context for WebGL');
        return;
    }

    gl.clearColor(1, 1, 1, 1);

    // Initialize shaders
    if (!initShaders(gl, VSHADER_SOURCE, FSHADER_SOURCE)) {
        console.log('Failed to intialize shaders.');
        return;
    }
    
    const n = initVertexBuffers(gl);

    const u_FragColor = gl.getUniformLocation(gl.program, 'u_FragColor');
    if (u_FragColor < 0) {
        console.log('Failed to get the storage location of u_FragColor');
        return -1;
    }
    gl.uniform4fv(u_FragColor, [1, 1, 1, 1]); // white

    const u_kD = gl.getUniformLocation(gl.program, 'u_kD');
    if (u_kD < 0) {
        console.log('Failed to get the storage location of u_kD');
        return -1;
    }
    let kD = [0.5075, 0.5075, 0.5075];
    gl.uniform3fv(u_kD, kD);

    const u_lightSource = gl.getUniformLocation(gl.program, 'u_lightSource');
    if (u_lightSource < 0) {
        console.log('Failed to get the storage location of u_lightSource');
        return -1;
    }
    let lightSource = glMatrix.vec3.fromValues(0, 0, 1);
    gl.uniform3fv(u_lightSource, lightSource);


    if (n < 0) {
        console.log('Failed to set the positions of the vertices');
        return;
    }
    const u_ViewMatrix = gl.getUniformLocation(gl.program, 'u_ViewMatrix');
    if (!u_ViewMatrix) {
        console.log('Failed to get the storage location of u_ViewMatrix');
        return;
    }

    const u_ProjectionMatrix = gl.getUniformLocation(gl.program, 'u_ProjectionMatrix');
    if (!u_ProjectionMatrix) {
        console.log('Failed to get the storage location of u_ProjectionMatrix');
        return;
    }

    const u_PerspectiveMatrix = gl.getUniformLocation(gl.program, 'u_PerspectiveMatrix');
    if (!u_PerspectiveMatrix) {
        console.log('Failed to get the storage location of u_PerspectiveMatrix');
        return;
    }

    const reverseLightDirectionLocation = gl.getUniformLocation(gl.program, "u_ReverseLightDirection");
    if (!reverseLightDirectionLocation) {
        console.log('Failed to get the storage location of u_ReverseLightDirection');
        return;
    }
    // Задаём направление света
    let vecReverseLightDirection = glMatrix.vec3.create();
    glMatrix.vec3.normalize(vecReverseLightDirection, [0, 0, 1]);
    gl.uniform3fv(reverseLightDirectionLocation, vecReverseLightDirection);

    let modelViewMatrix = glMatrix.mat4.create();

    // glMatrix.mat4.lookAt(modelViewMatrix, [0,0,-0.5],[0,0,0],[1,0,0]); //нижняя грань
    // glMatrix.mat4.lookAt(modelViewMatrix, [0,0,0.5],[0,0,0],[1,0,0]); //верхняя грань
    // glMatrix.mat4.lookAt(modelViewMatrix, [0,0.5,0],[0,0,0],[0,0,1]); //боковая грань

    // glMatrix.mat4.lookAt(modelViewMatrix, [0.5,0.5,1],[0,0,0],[-1,-1,1]); //аксонометрическая проекция
    glMatrix.mat4.lookAt(modelViewMatrix, [0.5, 0.5, 0.5], [0, 0, 0], [-1, -1, 1]); //изометрическая проекция
    console.log("modelViewMatrix", modelViewMatrix.toString());
    gl.uniformMatrix4fv(u_ViewMatrix, false, modelViewMatrix);
    // Clear <canvas>
    gl.clear(gl.COLOR_BUFFER_BIT);

    gl.enable(gl.DEPTH_TEST);
    // gl.clear(gl.DEPTH_BUFFER_BIT);

    let modelProjectionMatrix = glMatrix.mat4.create();
    glMatrix.mat4.ortho(modelProjectionMatrix, -1, 1, -1, 1, -2, 2); //ортогональная проекция
    console.log("modelProjectionMatrix", modelProjectionMatrix.toString());
    gl.uniformMatrix4fv(u_ProjectionMatrix, false, modelProjectionMatrix);

    let modelPerspectiveMatrix = glMatrix.mat4.create();
    // glMatrix.mat4.perspective(modelPerspectiveMatrix, 3.14/2, 1, 0.5, 1) //перспективная проекция
    //glMatrix.mat4.frustum(modelPerspectiveMatrix, -1, 1, -1, 1, 0.5, 1) //перспективная проекция (второй способ)
    console.log("modelPerspectiveMatrix", modelPerspectiveMatrix.toString());
    gl.uniformMatrix4fv(u_PerspectiveMatrix, false, modelPerspectiveMatrix);


    // Draw
    gl.drawElements(gl.TRIANGLES, 36, gl.UNSIGNED_SHORT, 0);

}

function initVertexBuffers(gl) {
    const n = 24; // The number of vertices
    let vertices = [
        // лицевая часть
        -0.4, -0.4, 0.4,
        -0.4, 0.4, 0.4,
        0.4, 0.4, 0.4,
        0.4, -0.4, 0.4,
        // задняя часть
        -0.4, -0.4, -0.4,
        -0.4, 0.4, -0.4,
        0.4, 0.4, -0.4,
        0.4, -0.4, -0.4
    ];

    let indices = [ // лицевая часть
        0, 1, 2,
        2, 3, 0,
        //нижняя часть
        0, 4, 7,
        7, 3, 0,
        // левая боковая часть
        0, 1, 5,
        5, 4, 0,
        // правая боковая часть
        2, 3, 7,
        7, 6, 2,
        // верхняя часть
        2, 1, 6,
        6, 5, 1,
        // задняя часть
        4, 5, 6,
        6, 7, 4,
    ];

    // установка буфера вершин
    let vertexBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer);
    gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(vertices), gl.STATIC_DRAW);
    vertexBuffer.itemSize = 3;

    // создание буфера индексов
    let indexBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, indexBuffer);
    gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, new Uint16Array(indices), gl.STATIC_DRAW);
    // указываем число индексов это число равно числу индексов
    indexBuffer.numberOfItems = indices.length;

    let normals = [
        // лицевая часть
        -1 / Math.sqrt(3), -1 / Math.sqrt(3), 1 / Math.sqrt(3),
        -1 / Math.sqrt(3), 1 / Math.sqrt(3), 1 / Math.sqrt(3),
        1 / Math.sqrt(3), 1 / Math.sqrt(3), 1 / Math.sqrt(3),
        1 / Math.sqrt(3), -1 / Math.sqrt(3), 1 / Math.sqrt(3),
        // задняя часть
        -1 / Math.sqrt(3), -1 / Math.sqrt(3), -1 / Math.sqrt(3),
        -1 / Math.sqrt(3), 1 / Math.sqrt(3), -1 / Math.sqrt(3),
        1 / Math.sqrt(3), 1 / Math.sqrt(3), -1 / Math.sqrt(3),
        1 / Math.sqrt(3), -1 / Math.sqrt(3), -1 / Math.sqrt(3)
    ];
    console.log(normals);

    let normalsBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, normalsBuffer);
    gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(normals), gl.STATIC_DRAW);
    normalsBuffer.itemSize = 3;

    const a_Position = gl.getAttribLocation(gl.program, 'a_Position');
    if (a_Position < 0) {
        console.log('Failed to get the storage location of a_Position');
        return -1;
    }

    const a_Normal = gl.getAttribLocation(gl.program, 'a_Normal');
    if (a_Normal < 0) {
        console.log('Failed to get the storage location of a_Normal');
        return -1;
    }

    gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer);
    gl.vertexAttribPointer(a_Position, vertexBuffer.itemSize, gl.FLOAT, false, 0, 0);
    gl.enableVertexAttribArray(a_Position);

    //gl.bindBuffer(gl.ARRAY_BUFFER, normalsBuffer);
    gl.vertexAttribPointer(a_Normal, normalsBuffer.itemSize, gl.FLOAT, false, 0, 0);
    gl.enableVertexAttribArray(a_Normal);


    // gl.bindBuffer(gl.ARRAY_BUFFER, colorBuffer);
    // gl.vertexAttribPointer(a_FragColor, vertexBuffer.itemSize, gl.FLOAT, false, 0, 0);
    // gl.enableVertexAttribArray(a_FragColor);


    return n;
}


function linearArray(arr, dim) {
    let res = new Float32Array(arr.length * dim);
    for (let i = 0; i < arr.length; i++) {
        for (let j = 0; j < dim; j++) {
            res[dim * i + j] = arr[i][j];
        }
    }
    return res;
}