

// 04.js

"use strict";

// Vertex shader program
const VSHADER_SOURCE =
    '#version 100\n' +
  'attribute vec4 a_Position;\n' +
  'attribute float a_PointSize;\n' +
  'attribute vec4 a_FragColor;\n' +
  'varying vec4 v_FragColor;\n' +
  // 'uniform mat4 u_ModelMatrix;\n' +
  'uniform mat4 u_ViewMatrix;\n' +
  'uniform mat4 u_ProjectionMatrix;\n' +
  'uniform mat4 u_PerspectiveMatrix;\n' +
  'void main() {\n' +
  '  gl_Position = u_PerspectiveMatrix*u_ProjectionMatrix*u_ViewMatrix*a_Position;\n' +
  '  gl_PointSize = a_PointSize;\n' +
  '  v_FragColor = a_FragColor;\n' +
  '}\n';

// Fragment shader program
const FSHADER_SOURCE =
  'precision mediump float;\n' +
  'varying vec4 v_FragColor;\n' +
  // 'uniform float u_Width;\n' +
  // 'uniform float u_Height;\n' +
  'void main() {\n' +
  'gl_FragColor = v_FragColor;\n' +
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
  // const u_Width = gl.getUniformLocation(gl.program, 'u_Width');
  // if (!u_Width) {
     // console.log('Failed to get the storage location of u_Width');
     // return;
  // }
  
  // gl.uniform1f(u_Width, 400.0);
  
   // const u_Height = gl.getUniformLocation(gl.program, 'u_Height');
  // if (!u_Height) {
     // console.log('Failed to get the storage location of u_Height');
     // return;
  // }
  // gl.uniform1f(u_Height, 400.0);

  // Write the positions of vertices to a vertex shader
  const n = initVertexBuffers(gl);
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
  
  let modelViewMatrix = glMatrix.mat4.create();

  // glMatrix.mat4.lookAt(modelViewMatrix, [0,0,-0.5],[0,0,0],[1,0,0]); //нижняя грань
  // glMatrix.mat4.lookAt(modelViewMatrix, [0,0,0.5],[0,0,0],[1,0,0]); //верхняя грань
  // glMatrix.mat4.lookAt(modelViewMatrix, [0,0.5,0],[0,0,0],[0,0,1]); //боковая грань
  // glMatrix.mat4.lookAt(modelViewMatrix, [0.5,0.5,1],[0,0,0],[-1,-1,1]); //аксонометрическая проекция
  glMatrix.mat4.lookAt(modelViewMatrix, [0.5,0.5,0.5],[0,0,0],[-1,-1,1]); //изометрическая проекция
  // console.log("modelViewMatrix", modelViewMatrix.toString());
  // gl.uniformMatrix4fv(u_ViewMatrix, false, modelViewMatrix);
   // Clear <canvas>
  gl.clear(gl.COLOR_BUFFER_BIT);
  
  gl.enable(gl.DEPTH_TEST);
  // gl.clear(gl.DEPTH_BUFFER_BIT);

  let modelProjectionMatrix = glMatrix.mat4.create();
  glMatrix.mat4.ortho(modelProjectionMatrix, -1, 1, -1, 1, -2, 2); //ортогональная проекция
  console.log("modelProjectionMatrix", modelProjectionMatrix.toString());
  gl.uniformMatrix4fv(u_ProjectionMatrix, false, modelProjectionMatrix);
  
  //перспективная проекция
  let modelPerspectiveMatrix = glMatrix.mat4.create();
  // glMatrix.mat4.perspective(modelPerspectiveMatrix, 1.5, 1, 0.01, 100) //perspective
  //glMatrix.mat4.frustum(modelPerspectiveMatrix, -1, 1, -1, 1, 0.5, 1) //frustum(второй способ)
  //одноточечная проекция
  // glMatrix.mat4.lookAt(modelViewMatrix, [1,0,0],[0,0,0],[0,0,1]);
  console.log("modelViewMatrix", modelViewMatrix.toString());
  gl.uniformMatrix4fv(u_ViewMatrix, false, modelViewMatrix);
  //двухточечная проекция
  // glMatrix.mat4.lookAt(modelViewMatrix, [1,1,0],[0,0,0],[0,0,1]);
  // console.log("modelViewMatrix", modelViewMatrix.toString());
  // gl.uniformMatrix4fv(u_ViewMatrix, false, modelViewMatrix);
  //трехточечная проекция
  // glMatrix.mat4.lookAt(modelViewMatrix, [0.5,0.5,0.5],[0,0,0],[-1,-1,1]);
  // console.log("modelViewMatrix", modelViewMatrix.toString());
  // gl.uniformMatrix4fv(u_ViewMatrix, false, modelViewMatrix);



  console.log("modelPerspectiveMatrix", modelPerspectiveMatrix.toString());
  gl.uniformMatrix4fv(u_PerspectiveMatrix, false, modelPerspectiveMatrix);

  // Draw 
  gl.drawElements(gl.LINES, 48, gl.UNSIGNED_SHORT,0);
  
}

function initVertexBuffers(gl) {
  const n = 24; // The number of vertices
  var vertices =[
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
                  
  var indices = [ // лицевая часть
                0, 1,
                1, 2,
                2, 3,
                3, 0,
                //нижняя часть
                0, 4,
                4, 7,
                7, 3,
                3, 0,
                // левая боковая часть
                0, 1,
                1, 5,
                5, 4,
                4, 0,
                // правая боковая часть
                2, 3,
                3, 7,
                7, 6,
                6, 2,
                // верхняя часть
                1, 2,
                2, 6,
                6, 5,
                5, 1,
                // задняя часть
                4, 5,
                5, 6,
                6, 7,
                7, 4
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
 
  // установка цветов для каждой вершины
  var сolors = [
        1.0, 0.0, 0.0, 1.0,
        1.0, 0.0, 0.0, 1.0,
        1.0, 0.0, 0.0, 1.0,
        1.0, 0.0, 0.0, 1.0,
         
        1.0, 0.0, 0.0, 1.0,
        1.0, 0.0, 0.0, 1.0,
        1.0, 0.0, 0.0, 1.0,
        1.0, 0.0, 0.0, 1.0
    ];
    let colorBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, colorBuffer);
    gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(сolors), gl.STATIC_DRAW);
 
    const a_Position = gl.getAttribLocation(gl.program, 'a_Position');
    if (a_Position < 0) {
      console.log('Failed to get the storage location of a_Position');
      return -1;
    }

    gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer);
    gl.vertexAttribPointer(a_Position, vertexBuffer.itemSize, gl.FLOAT, false, 0, 0);
    gl.enableVertexAttribArray(a_Position);
 
    const a_FragColor = gl.getAttribLocation(gl.program, 'a_FragColor');
    if (a_FragColor < 0) {
      console.log('Failed to get the storage location of a_FragColor');
      return -1;
    }

    gl.bindBuffer(gl.ARRAY_BUFFER, colorBuffer);
    gl.vertexAttribPointer(a_FragColor, vertexBuffer.itemSize, gl.FLOAT, false, 0, 0);
    gl.enableVertexAttribArray(a_FragColor);
  return n;
}


function linearArray(arr,dim){
  let res = new Float32Array(arr.length*dim);
  for(let i=0; i<arr.length; i++){
    for(let j=0; j<dim; j++){
      res[dim*i+j] = arr[i][j];
    }
  }
  return res;
}