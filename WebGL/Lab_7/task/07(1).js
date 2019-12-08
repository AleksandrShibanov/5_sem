"use strict";

const VSHADER_SOURCE =
  '#version 100\n' +
  'attribute vec3 a_Position;\n' +
  'attribute vec3 a_Colors;\n' +
  'uniform mat4 u_ModelMatrix;\n' +
  'uniform mat4 u_ViewMatrix;\n' +
  'uniform mat4 u_ProjectionMatrix;\n' +
  'varying vec3 v_Colors;\n' +
  'void main() {\n' +
  '  v_Colors = a_Colors;\n' +
  '  gl_Position = u_ProjectionMatrix * u_ViewMatrix * u_ModelMatrix * vec4(a_Position, 1.0);\n' +
  '}\n';

const FSHADER_SOURCE =
  'precision mediump float;\n' +
  'uniform int u_Mode;\n' +
  'varying vec3 v_Colors;\n' +
  'void main() {\n' +
  '  gl_FragColor = vec4(u_Mode == 0 ? vec3(1.0, 1.0, 1.0) : 0.4 * v_Colors.brg, u_Mode == 0 ? 1.0 : 0.7);\n' +
  '}\n';

function main() {
  const canvas = document.getElementById('webgl');
  //const fps_c = document.getElementById('fps');

  const gl = getWebGLContext(canvas);
  if (!gl) {
    console.log('Failed to get the rendering context for WebGL');
    return;
  }

  if (!initShaders(gl, VSHADER_SOURCE, FSHADER_SOURCE)) {
    console.log('Failed to intialize shaders.');
    return;
  }

  const indices = initVertexBuffers(gl);

  gl.enable(gl.DEPTH_TEST);
  gl.enable(gl.BLEND);
  gl.blendFunc(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA);
  gl.lineWidth(2);

  let model = new mat4.create();
  let view = new mat4.create();
  let proj = new mat4.create();

  //mat4.ortho(proj, -1.0, 1.0, -0.66, 0.66, 0.01, 100.0);
  mat4.perspective(proj, 1.0, (canvas.width / canvas.height), 0.001, 10.0);
  //mat4.frustum(proj, -0.6, 0.6, -0.4, 0.4, 0.5, 5.0);

  const u_ViewMatrix = gl.getUniformLocation(gl.program, 'u_ViewMatrix');
  if (u_ViewMatrix < 0) {
    console.log('Failed to get the storage location of u_ViewMatrix');
    return -1;
  }

  const u_ProjectionMatrix = gl.getUniformLocation(gl.program, 'u_ProjectionMatrix');
  if (u_ProjectionMatrix < 0) {
    console.log('Failed to get the storage location of u_ProjectionMatrix');
    return -1;
  }

  const u_ModelMatrix = gl.getUniformLocation(gl.program, 'u_ModelMatrix');
  if (u_ProjectionMatrix < 0) {
    console.log('Failed to get the storage location of u_ModelMatrix');
    return -1;
  }

  const u_Mode = gl.getUniformLocation(gl.program, 'u_Mode');
  if (u_ProjectionMatrix < 0) {
    console.log('Failed to get the storage location of u_Mode');
    return -1;
  }

  gl.clearColor(0.0, 0.0, 0.0, 1);

  gl.uniformMatrix4fv(u_ProjectionMatrix, false, proj);

  let g_last = Date.now();
  let angle = 0.0;

  function req() {

    let current_time = Date.now();
    let elapsed = current_time - g_last;
    g_last = current_time;

    //fps_c.innerHTML = "FPS: " + Math.round(1.0 / (elapsed / 1000.0));

    angle = draw(gl, angle, u_ViewMatrix, u_ModelMatrix, indices, elapsed, u_Mode);
    requestAnimationFrame(req);
  };

  requestAnimationFrame(req);
}

function draw(gl, angle, u_ViewMatrix, u_ModelMatrix, indices, elapsed, u_Mode) {
  gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);

  let new_angle = (angle + (elapsed) / 1000.0) % 6.28;
  let matrix = new mat4.create();

  mat4.lookAt(matrix, [2.0 * Math.cos(new_angle), 1.0, 2.0 * Math.sin(new_angle)],
                      [0.0, 0.0, 0.0],
                      [0.0, 1.0, 0.0]);
  gl.uniformMatrix4fv(u_ViewMatrix, false, matrix);

  mat4.fromZRotation(matrix, new_angle);
  gl.uniformMatrix4fv(u_ModelMatrix, false, matrix);

  gl.uniform1i(u_Mode, 0);
  gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, indices[0]);
  gl.drawElements(gl.LINES, 24, gl.UNSIGNED_BYTE, 0);

  mat4.scale(matrix, matrix, [0.95, 0.95, 0.95]);
  gl.uniformMatrix4fv(u_ModelMatrix, false, matrix);
  gl.drawElements(gl.LINES, 24, gl.UNSIGNED_BYTE, 0);

  gl.uniform1i(u_Mode, 1);
  gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, indices[1]);
  gl.drawElements(gl.TRIANGLES, 36, gl.UNSIGNED_BYTE, 0);

  return new_angle;
}

function initVertexBuffers(gl) {
  const n = 3;

  const vertices = new Float32Array(
    [-0.5, -0.5, 0.5, 1.0, 0.0, 0.0, //
      0.5, -0.5, 0.5, 1.0, 0.0, 1.0,
      0.5, 0.5, 0.5, 1.0, 1.0, 1.0,
      -0.5, 0.5, 0.5, 1.0, 1.0, 0.0,
      -0.5, -0.5, -0.5, 0.2, 0.2, 0.2,
      0.5, -0.5, -0.5, 0.0, 1.0, 0.0, //
      0.5, 0.5, -0.5, 0.0, 1.0, 1.0,
      -0.5, 0.5, -0.5, 0.0, 0.0, 1.0, //
    ]);

  const indices = new Uint8Array(
    [0, 1, 1, 2, 2, 3, 3, 0, 4, 5, 5, 6,
      6, 7, 7, 4, 0, 4, 1, 5, 2, 6, 3, 7
    ]);

  const solid_indices = new Uint8Array(
    [0, 1, 3, 1, 2, 3, 1, 5, 2, 5, 6, 2,
      5, 4, 6, 4, 7, 6, 4, 0, 7, 0, 3, 7,
      3, 2, 7, 2, 6, 7, 5, 1, 4, 1, 0, 4
    ]);

  const vertexBuffer = gl.createBuffer();
  if (!vertexBuffer) {
    console.log('Failed to create the buffer object');
    return -1;
  }

  gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer);
  gl.bufferData(gl.ARRAY_BUFFER, vertices, gl.STATIC_DRAW);

  const indexLinesBuffer = gl.createBuffer();
  if (!indexLinesBuffer) {
    console.log('Failed to create the index object');
    return -1;
  }

  gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, indexLinesBuffer);
  gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, indices, gl.STATIC_DRAW);

  const indexTrianglesBuffer = gl.createBuffer();
  if (!indexTrianglesBuffer) {
    console.log('Failed to create the index object');
    return -1;
  }

  gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, indexTrianglesBuffer);
  gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, solid_indices, gl.STATIC_DRAW);

  const a_Position = gl.getAttribLocation(gl.program, 'a_Position');
  if (a_Position < 0) {
    console.log('Failed to get the storage location of a_Position');
    return -1;
  }

  const a_Colors = gl.getAttribLocation(gl.program, 'a_Colors');
  if (a_Colors < 0) {
    console.log('Failed to get the storage location of a_Colors');
    return -1;
  }

  gl.vertexAttribPointer(a_Position, 3, gl.FLOAT, false, 4 * 6, 0 * 4);
  gl.enableVertexAttribArray(a_Position);

  gl.vertexAttribPointer(a_Colors, 3, gl.FLOAT, false, 4 * 6, 3 * 4);
  gl.enableVertexAttribArray(a_Colors);

  return [indexLinesBuffer, indexTrianglesBuffer];
}