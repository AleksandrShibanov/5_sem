// 04.js

"use strict";

// Vertex shader program
const VSHADER_SOURCE =
    '#version 100\n' +
  'attribute vec4 a_Position;\n' +
  'attribute float a_PointSize;\n' +
  'attribute vec4 a_FragColor;\n' +
  'varying vec4 v_FragColor;\n' +
  'void main() {\n' +
  '  gl_Position = a_Position;\n' +
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
  // 'gl_FragColor = vec4(gl_FragCoord.x/u_Width, 0.0, gl_FragCoord.y/u_Height, 0.6);\n' +
  'gl_FragColor = v_FragColor;\n' +
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

  // Specify the color for clearing <canvas>
  gl.clearColor(1, 1, 1, 1);

  // Clear <canvas>
  gl.clear(gl.COLOR_BUFFER_BIT);



  // Draw three points
    gl.drawArrays(gl.TRIANGLES, 0, 3);
    gl.enable(gl.BLEND);
    gl.blendFunc(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA);
    gl.drawArrays(gl.TRIANGLES, 3, 3);
}

function initVertexBuffers(gl) {
    const n = 6; // The number of vertices

    // const vertices = new Float32Array([0.0, 0.5, -0.5, -0.5, 0.5, -0.5]);

    const vertices = new Float32Array(2 * n);

    vertices[0] = -1.0/3;
    vertices[1] = -1.0/3;
    vertices[2] = -1.0/3;
    vertices[3] = 1.0/3;
    vertices[4] = 1.0/3;
    vertices[5] = 0.0/3;
	vertices[6] = 1.0/3;
    vertices[7] = 1.0;
    vertices[8] = -1.0;
    vertices[9] = 0.0;
    vertices[10] = 1.0;
    vertices[11] = -1.0;

    const vertixSizes = new Float32Array(n);

    vertixSizes[0] = 10.0;
    vertixSizes[1] = 20.0;
    vertixSizes[2] = 30.0;
	vertixSizes[3] = 10.0;
    vertixSizes[4] = 20.0;
    vertixSizes[5] = 30.0;
    vertixSizes[6] = 10.0;
    vertixSizes[7] = 20.0;
    vertixSizes[8] = 30.0;
  vertixSizes[9] = 10.0;
    vertixSizes[10] = 20.0;
    vertixSizes[11] = 30.0;


	const vertixColors = new Float32Array(4*n);

    vertixColors[0] = 1.0;
    vertixColors[1] = 0.0;
    vertixColors[2] = 0.0;
	vertixColors[3] = 1.0;
	
	vertixColors[4] = 1.0;
    vertixColors[5] = 0.0;
    vertixColors[6] = 0.0;
	vertixColors[7] = 1.0;
	
	vertixColors[8] = 1.0;
    vertixColors[9] = 0.0;
    vertixColors[10] = 0.0;
	vertixColors[11] = 1.0;
	
	vertixColors[12] = 0.0;
    vertixColors[13] = 0.0;
    vertixColors[14] = 1.0;
	vertixColors[15] = 0.7;
	
	vertixColors[16] = 0.0;
    vertixColors[17] = 0.0;
    vertixColors[18] = 1.0;
	vertixColors[19] = 0.7;
	
	vertixColors[20] = 0.0;
    vertixColors[21] = 0.0;
    vertixColors[22] = 1.0;
	vertixColors[23] = 0.7;
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


