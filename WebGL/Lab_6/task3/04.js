

// 04.js

"use strict";

// Vertex shader program
const VSHADER_SOURCE =
    '#version 100\n' +
  'attribute vec4 a_Position;\n' +
  'attribute float a_PointSize;\n' +
  'attribute vec4 a_FragColor;\n' +
  'varying vec4 v_FragColor;\n' +
  'uniform mat4 u_ModelMatrix;\n' +
  'void main() {\n' +
  '  gl_Position = u_ModelMatrix*a_Position;\n' +
  '  gl_PointSize = a_PointSize;\n' +
  '  v_FragColor = a_FragColor;\n' +
  '}\n';

// Fragment shader program
const FSHADER_SOURCE =
  'precision mediump float;\n' +
  'varying vec4 v_FragColor;\n' +
  'uniform float u_Width;\n' +
  'uniform float u_Height;\n' +
  'void main() {\n' +
  'gl_FragColor = vec4(gl_FragCoord.x/u_Width, 0.0, gl_FragCoord.y/u_Height, 1.0);\n' +
  // 'if (distance(vec2(0.5,0.5), gl_PointCoord) > 0.5)' +
  // 'discard;\n' +
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

  const u_Width = gl.getUniformLocation(gl.program, 'u_Width');
  if (!u_Width) {
     console.log('Failed to get the storage location of u_Width');
     return;
  }
  
  gl.uniform1f(u_Width, 400.0);
  
   const u_Height = gl.getUniformLocation(gl.program, 'u_Height');
  if (!u_Height) {
     console.log('Failed to get the storage location of u_Height');
     return;
  }
  gl.uniform1f(u_Height, 400.0);

  // Write the positions of vertices to a vertex shader
  const n = initVertexBuffers(gl);
  if (n < 0) {
    console.log('Failed to set the positions of the vertices');
    return;
  }
  
    const u_ModelMatrix = gl.getUniformLocation(gl.program, 'u_ModelMatrix');
  if (!u_ModelMatrix) {
     console.log('Failed to get the storage location of u_ModelMatrix');
     return;
  }
  

  let now = Date.now();
  let angle = 0;
  let modelRotateMatrix = glMatrix.mat4.create();
  let a = function()
  { 
	  let g_last = now;
	  now = Date.now();
	  let elapsed = now - g_last;
	  let newAngle = angle + (Math.PI/2 * elapsed) / 1000.0;
	  angle = newAngle;
	  glMatrix.mat4.fromRotation(modelRotateMatrix,newAngle,[0,0,1]);
	  console.log(modelRotateMatrix.toString());
	  gl.uniformMatrix4fv(u_ModelMatrix, false, modelRotateMatrix);


	  // Clear <canvas>
	  gl.clear(gl.COLOR_BUFFER_BIT);

	  // Draw three points
	   gl.drawArrays(gl.TRIANGLES, 0, n);
	   console.log("!");
	   if(angle <2*Math.PI)
          window.requestAnimationFrame(a);
  }
 
   window.requestAnimationFrame(a);
}

function initVertexBuffers(gl) {
    const n = 3; // The number of vertices

    // const vertices = new Float32Array([0.0, 0.5, -0.5, -0.5, 0.5, -0.5]);

    const vertices = new Float32Array(2 * n);

    vertices[0] = -0.5;
    vertices[1] = -0.5;
    vertices[2] = -0.5;
    vertices[3] = 0.0;
    vertices[4] = 1.0;
    vertices[5] = 0.1;

    const vertixSizes = new Float32Array(n);

    vertixSizes[0] = 10.0;
    vertixSizes[1] = 20.0;
    vertixSizes[2] = 30.0;


	const vertixColors = new Float32Array(4*n);

    vertixColors[0] = 1.0;
    vertixColors[1] = 0.0;
    vertixColors[2] = 0.0;
	vertixColors[3] = 1.0;
	
	vertixColors[4] = 0.0;
    vertixColors[5] = 1.0;
    vertixColors[6] = 0.0;
	vertixColors[7] = 1.0;
	
	vertixColors[8] = 0.0;
    vertixColors[9] = 0.0;
    vertixColors[10] = 1.0;
	vertixColors[11] = 1.0;
  // Create a buffer object
  const vertexBuffer = gl.createBuffer();
  if (!vertexBuffer) {
    console.log('Failed to create the buffer object');
    return -1;
  }

  // Bind the buffer object to target
  gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer);
  // Write date into the buffer object
  var FSIZE = vertices.BYTES_PER_ELEMENT;
  gl.bufferData(gl.ARRAY_BUFFER, 7*n*FSIZE, gl.STATIC_DRAW);
  
   const a_PointSize = gl.getAttribLocation(gl.program, 'a_PointSize');
  if (a_PointSize < 0) {
    console.log('Failed to get the storage location of a_Position');
    return -1;
  }
   gl.bufferSubData(gl.ARRAY_BUFFER,0,vertixSizes);
  //Assign the buffer object to a_PointSize variable
  gl.vertexAttribPointer(a_PointSize, 1, gl.FLOAT, false, 0,0 );

  //Enable the assignment to a_PointSize variable
  gl.enableVertexAttribArray(a_PointSize);
  
  const a_Position = gl.getAttribLocation(gl.program, 'a_Position');
  if (a_Position < 0) {
    console.log('Failed to get the storage location of a_Position');
    return -1;
  }
  gl.bufferSubData(gl.ARRAY_BUFFER,n*FSIZE,vertices)
  // Assign the buffer object to a_Position variable
  gl.vertexAttribPointer(a_Position, 2, gl.FLOAT, false, 0, n*FSIZE);
  
  // Enable the assignment to a_Position variable
  gl.enableVertexAttribArray(a_Position);

    const a_FragColor = gl.getAttribLocation(gl.program, 'a_FragColor');
  if (a_FragColor < 0) {
    console.log('Failed to get the storage location of a_FragColor');
    return -1;
  }
  
   gl.bufferSubData(gl.ARRAY_BUFFER,3*n*FSIZE,vertixColors);
  //Assign the buffer object to a_FragColor variable
  gl.vertexAttribPointer(a_FragColor, 4, gl.FLOAT, false, 0,3*n*FSIZE );

  //Enable the assignment to a_FragColor variable
  gl.enableVertexAttribArray(a_FragColor);
  
  

  return n;
}


