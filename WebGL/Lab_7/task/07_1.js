

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

	  //glMatrix.mat4.lookAt(modelViewMatrix, [0,0,-0.5],[0,0,0],[1,0,0]); //нижняя грань
	  //glMatrix.mat4.lookAt(modelViewMatrix, [0,0,0.7],[0,0,0],[1,0,0]); //верхняя грань
	 //glMatrix.mat4.lookAt(modelViewMatrix, [0,0.5,0],[0,0,0],[0,0,1]); //боковая грань
	
	 //glMatrix.mat4.lookAt(modelViewMatrix, [0.5,0.5,1],[0,0,0],[-1,-1,1]); //аксонометрическая проекция
	//glMatrix.mat4.lookAt(modelViewMatrix, [0.4,0.4,0.4],[0,0,0],[-1,-1,1]); //изометрическая проекция
	console.log("modelViewMatrix", modelViewMatrix.toString());
	gl.uniformMatrix4fv(u_ViewMatrix, false, modelViewMatrix);
   // Clear <canvas>
	gl.clear(gl.COLOR_BUFFER_BIT);
	

	let modelProjectionMatrix = glMatrix.mat4.create();
	gl.uniformMatrix4fv(u_ProjectionMatrix, false, modelProjectionMatrix);
	
	//перспективная проекция
  let modelPerspectiveMatrix = glMatrix.mat4.create();
 
  
  gl.uniformMatrix4fv(u_ViewMatrix, false, modelViewMatrix);;
  gl.uniformMatrix4fv(u_PerspectiveMatrix, false, modelPerspectiveMatrix);
  
  console.log("modelViewMatrix", modelViewMatrix.toString());
  console.log("modelPerspectiveMatrix", modelPerspectiveMatrix.toString());
	
	// Draw 
	gl.drawArrays(gl.LINES, 0, n);
	// gl.drawElements(gl.LINES, 8,  gl.UNSIGNED_BYTE, 0 );
  
}

function initVertexBuffers(gl) {
    const n = 24; // The number of vertices

    // const vertices = new Float32Array([0.0, 0.4, -0.4, -0.4, 0.4, -0.4]);

    let vertices = [];
	
	vertices[0]=[0.4,0.4,0.4];
	vertices[1]=[-0.4,0.4,0.4];
	
	vertices[2]=[-0.4,0.4,0.4];
	vertices[3]=[-0.4,-0.4,0.4];
	
	vertices[4]=[-0.4,-0.4,0.4];
	vertices[5]=[0.4,-0.4,0.4];
	
	vertices[6]=[0.4,-0.4,0.4];
	vertices[7]=[0.4,0.4,0.4];
	
	vertices[8]=[0.4,0.4,-0.4];
	vertices[9]=[-0.4,0.4,-0.4];
	
	vertices[10]=[-0.4,0.4,-0.4];
	vertices[11]=[-0.4,-0.4,-0.4];
	
	vertices[12]=[-0.4,-0.4,-0.4];
	vertices[13]=[0.4,-0.4,-0.4];
	
	vertices[14]=[0.4,-0.4,-0.4];
	vertices[15]=[0.4,0.4,-0.4];
	
	vertices[16]=[-0.4,0.4,-0.4];
	vertices[17]=[-0.4,0.4,0.4];
	
	vertices[18]=[0.4,0.4,0.4];
	vertices[19]=[0.4,0.4,-0.4];
	
	vertices[20]=[-0.4,-0.4,0.4];
	vertices[21]=[-0.4,-0.4,-0.4];
	
	vertices[22]=[0.4,-0.4,0.4];
	vertices[23]=[0.4,-0.4,-0.4];


	let vertixColors = [];

    vertixColors[0]=[0.0,1.0,0.0,1.0];
	vertixColors[1]=[0.0,1.0,0.0,1.0];
	
	vertixColors[2]=[0.0,1.0,0.0,1.0];
	vertixColors[3]=[0.0,1.0,0.0,1.0];
	
	vertixColors[4]=[0.0,1.0,0.0,1.0];
	vertixColors[5]=[0.0,1.0,0.0,1.0];
	
	vertixColors[6]=[0.0,1.0,0.0,1.0];
	vertixColors[7]=[0.0,1.0,0.0,1.0];
	
	vertixColors[8]=[0.0,0.0,1.0,1.0];
	vertixColors[9]=[0.0,0.0,1.0,1.0];
	
	vertixColors[10]=[0.0,0.0,1.0,1.0];
	vertixColors[11]=[0.0,0.0,1.0,1.0];
	
	vertixColors[12]=[0.0,0.0,1.0,1.0];
	vertixColors[13]=[0.0,0.0,1.0,1.0];
	
	vertixColors[14]=[0.0,0.0,1.0,1.0];
	vertixColors[15]=[0.0,0.0,1.0,1.0];
	
	vertixColors[16]=[1.0,0.0,0.0,1.0];
	vertixColors[17]=[1.0,0.0,0.0,1.0];
	
	vertixColors[18]=[1.0,0.0,0.0,1.0];
	vertixColors[19]=[1.0,0.0,0.0,1.0];
	
	vertixColors[20]=[1.0,0.0,0.0,1.0];
	vertixColors[21]=[1.0,0.0,0.0,1.0];
	
	vertixColors[22]=[1.0,0.0,0.0,1.0];
	vertixColors[23]=[1.0,0.0,0.0,1.0];
    
	
	
  // Create a buffer object
  const vertexBuffer = gl.createBuffer();
  if (!vertexBuffer) {
    console.log('Failed to create the buffer object');
    return -1;
  }

  
  
  
  const verticesLinear = linearArray(vertices,3);
    var FSIZE = verticesLinear.BYTES_PER_ELEMENT;
  console.log(verticesLinear);
  
  const a_Position = gl.getAttribLocation(gl.program, 'a_Position');
  if (a_Position < 0) {
    console.log('Failed to get the storage location of a_Position');
    return -1;
  }
  // Bind the buffer object to target
  gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer);
  // Write date into the buffer object
  gl.bufferData(gl.ARRAY_BUFFER, 7*n*FSIZE, gl.STATIC_DRAW);
  gl.bufferSubData(gl.ARRAY_BUFFER,0,verticesLinear);
  // Assign the buffer object to a_Position variable
  gl.vertexAttribPointer(a_Position, 3, gl.FLOAT, false, 0, 0);
  
  // Enable the assignment to a_Position variable
  gl.enableVertexAttribArray(a_Position);

  const vertixColorsLinear = linearArray(vertixColors,4);
    var FSIZE = vertixColorsLinear.BYTES_PER_ELEMENT;
  console.log(vertixColorsLinear);

    const a_FragColor = gl.getAttribLocation(gl.program, 'a_FragColor');
  if (a_FragColor < 0) {
    console.log('Failed to get the storage location of a_FragColor');
    return -1;
  }
  
   gl.bufferSubData(gl.ARRAY_BUFFER,3*n*FSIZE,vertixColorsLinear);
  //// Assign the buffer object to a_FragColor variable
  gl.vertexAttribPointer(a_FragColor, 4, gl.FLOAT, false, 0,3*n*FSIZE);

  //// Enable the assignment to a_FragColor variable
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