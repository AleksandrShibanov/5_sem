// 04.js


// Vertex shader program
const VSHADER_SOURCE =
    '#version 100\n' +
  'attribute vec4 a_Position;\n'+
  'attribute float a_size;\n'+
  'attribute vec4 a_color;\n '+
  'varying vec4 k_color;\n'+
 // 'varying float u_Width;\n '+
  //'varying float u_Height ;\n '+
 // 'attribute float a_Width;\n '+
 // 'attribute float a_Height ;\n '+
 'uniform mat4 motion;\n'+
  'void main() {\n' +
  '  gl_Position = motion*a_Position;\n' +
  //'  gl_Position = a_Position;\n' +
  '  gl_PointSize = a_size;\n' +
  'k_color = a_color;'+
 // ' u_Width = a_Width;'+
 // ' u_Height = a_Height;'+
  '}\n';

// Fragment shader program
const FSHADER_SOURCE =
 'precision mediump float;\n' +
'varying vec4 k_color ;\n '+
////через varying переменные
//'varying float u_Width;\n '+
//'varying float u_Height ;\n '+
'uniform float u_Width;\n'+
'uniform float u_Height;\n'+
  'void main() {\n' +
  //'gl_FragColor = vec4(gl_FragCoord.x/u_Width, 0.0,gl_FragCoord.y/u_Height, 1.0);'+
  //'if (distance(gl_PointCoord,vec2(0.5,0.5))>=0.5) discard;'+
  '  gl_FragColor = k_color;\n' +
  
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
    console.log('1');
  // Initialize shaders
    if (!initShaders(gl, VSHADER_SOURCE, FSHADER_SOURCE)) {
		console.log('Failed to intialize shaders.');
		return;
    }

  // Animation
	let g_last = Date.now();
    let now;
    let newAngle = 0.0;
    gl.clearColor(0, 0, 0, 1);
    let n = 0;
    gl.clearColor(0, 0, 0, 1);
    gl.enable(gl.BLEND);
	let mat_r = glMatrix.mat4.create();
    gl.blendFunc(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA);
	gl.clear(gl.COLOR_BUFFER_BIT);
    // let  newStepAnimation = function ()
									// {
										// now = Date.now();
										// let elapsed = now-g_last;
										// g_last = now;
										// newAngle = newAngle + ((Math.PI/3)*elapsed) / 1000.0;	
										// if 	(newAngle>2*Math.PI)
											// newAngle= newAngle-2*Math.PI;
										// glMatrix.mat4.fromRotation(mat_r,newAngle,[0,0,1]);
										// n = initVertexBuffers(gl,0, mat_r);
										// if (n < 0) {
										     // console.log('Failed to set the positions of the vertices');
										     // return;	
										// }
										// gl.clear(gl.COLOR_BUFFER_BIT);
										// gl.drawArrays(gl.LINE_LOOP, 0, n);
										// requestAnimationFrame(newStepAnimation);
									// }
  // requestAnimationFrame(newStepAnimation);
  gl.enable(gl.DEPTH_TEST);
  gl.clear(gl.DEPTH_BUFFER_BIT);

  // const coords_cube = [-0.5,0.5,-0.5,  -0.5, 0.5,0.5,  0.5,0.5, 0.5,  0.5,0.5,-0.5,  -0.5,-0.5,-0.5,  -0.5,-0.5,0.5,  0.5,-0.5, 0.5,  0.5,-0.5,-0.5,     -0.5,0.5,-0.5,  -0.5,-0.5,-0.5,     -0.5, 0.5,0.5, -0.5,-0.5,0.5,      0.5,0.5, 0.5, 0.5,-0.5, 0.5,    0.5,0.5,-0.5,   0.5,-0.5,-0.5]
  // n = initVertexBuffers(gl,[1,2,3,4], coords_cube, 0,[0.0, 1.0, 0.0, 1.0]);
  // gl.drawArrays(gl.LINE_LOOP, 0, n);

  // n = initVertexBuffers(gl,[1,2,3,4], coords_cube, 4*3,[0.0, 1.0, 0.0, 1.0]);
  // gl.drawArrays(gl.LINE_LOOP, 0, n);
 // gl.clear(gl.DEPTH_BUFFER_BIT);
   // n = initVertexBuffers(gl,[1,2], coords_cube, 10*3,[1.0, 1.0, 0, 1.0]);//top   cоответствуют желтому и зеленому ребру   желтое
  // gl.drawArrays(gl.LINES, 0, 2);
  
   // n = initVertexBuffers(gl,[1,2], coords_cube, 12*3,[0.0, 1.0, 0.0, 1.0]);//top зеленое
  // gl.drawArrays(gl.LINES, 0, 2);

   // n = initVertexBuffers(gl,[1,2], coords_cube, 8*3,[1.0, 0.0, 1.0, 1.0]); //соответствуют красному и фиолетовому ребру
   // gl.drawArrays(gl.LINES, 0, 2);
  
   // n = initVertexBuffers(gl,[1,2], coords_cube, 14*3,[1.0, 0.0, 0.0, 1.0]);
   // gl.drawArrays(gl.LINES, 0, 2);
  // coords = [-0.3,0,-2,  0.3,0,-2]
 // n = initVertexBuffers(gl,[1,2], coords, -1,[1.0, 0.0, 0.0, 1.0]);
   // gl.drawArrays(gl.LINES, 0, 2);
   
    size_obj = {val:0}
	
	n = initVertexBuffersElems(gl,size_obj)
	console.log(size_obj.val)
	//let step = 2
	let step = 3
	for(var i = 0; i<n; i+=step)
	{
		//gl.drawElements(gl.LINES, 3, gl.UNSIGNED_SHORT, i* size_obj.val)
		gl.drawElements(gl.TRIANGLES, 3, gl.UNSIGNED_SHORT, i* size_obj.val)
	}
	
	
 
}

function initVertexBuffersElems(gl,size_obj)
{
	const vertices = new Float32Array([-0.5,0.5,-0.5,   -0.5, 0.5,0.5,  0.5,0.5, 0.5,  0.5,0.5,-0.5,  -0.5,-0.5,-0.5,  -0.5,-0.5,0.5,  0.5,-0.5, 0.5,  0.5,-0.5,-0.5]);
    const sizes    = new Float32Array([10,10,10,10,10,10,10,10]);
    const colors   = new Float32Array([0.0, 1.0, 0.0, 1.0,0.0, 1.0, 0.0, 1.0,0.0, 1.0, 0.0, 1.0,0.0, 1.0, 0.0, 1.0,1.0, 0.0, 1.0, 1.0,1.0, 0.0, 1.0, 1.0,1.0, 0.0, 1.0, 1.0,1.0, 0.0, 1.0, 1.0]);
   // const indexes  = new Uint16Array([0,1,1,2,2,3,3,0,4,5,5,6,6,7,7,4,0,4,1,5,2,6,3,7])
    const indexes  = new Uint16Array([0,1,2,2,3,0, 0,1,5,5,4,0,  1,5,6,6,2,1,  2,6,7,7,3,2,  0,3,7,7,4,0 ,4,7,6,6,5,4])
    const vertexBuffer = gl.createBuffer();
    if (!vertexBuffer) {
		console.log('Failed to create the buffer object');
		return -1;
    }
    var FSIZE = vertices.BYTES_PER_ELEMENT;
    gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer);
    gl.bufferData(gl.ARRAY_BUFFER, (vertices.length+sizes.length)*FSIZE+ colors.length*FSIZE, gl.STATIC_DRAW);
    gl.bufferSubData(gl.ARRAY_BUFFER, 0, sizes);
    gl.bufferSubData(gl.ARRAY_BUFFER, FSIZE*sizes.length, vertices);
    gl.bufferSubData(gl.ARRAY_BUFFER, FSIZE*(sizes.length+vertices.length), colors);
	
	const indexBuffer = gl.createBuffer();
	var ISIZE         =  indexes.BYTES_PER_ELEMENT;
	gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, indexBuffer);
	gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, indexes, gl.STATIC_DRAW);
	
	
	const a_Position = gl.getAttribLocation(gl.program, 'a_Position');
    if (a_Position < 0) {
		console.log('Failed to get the storage location of a_Position');
		return -1;
    }
	 const a_Size = gl.getAttribLocation(gl.program, 'a_size');
	if (a_Size < 0) {
		console.log('Failed to get the storage location of a_Position');
		return -1;
    }
	const u_motion = gl.getUniformLocation(gl.program, 'motion');
	let out = glMatrix.mat4.create();
	glMatrix.mat4.lookAt(out, [0.7,0.7,0.7], [0,0,0], [0,1,0])
	let ort = glMatrix.mat4.create();
	glMatrix.mat4.ortho(ort, -1, 1,-1, 1, 0.01, 2)
	glMatrix.mat4.multiply(out,ort,out);
	gl.uniformMatrix4fv (u_motion, false, out)
	gl.uniformMatrix4fv (u_motion, false, out);
	
	const a_Color = gl.getAttribLocation(gl.program, 'a_color');
	const u_Width = gl.getUniformLocation(gl.program, 'u_Width');
    const u_Heigh = gl.getUniformLocation(gl.program, 'u_Heigh');
	gl.uniform1f(u_Width, gl.drawingBufferWidth);
    gl.uniform1f(u_Heigh, gl.drawingBufferHeight);
	
	gl.vertexAttribPointer(a_Position, 3, gl.FLOAT, false, 0,  FSIZE*sizes.length);
    gl.vertexAttribPointer(a_Size, 1, gl.FLOAT, false, 0, 0);
    gl.vertexAttribPointer(a_Color, 4, gl.FLOAT, false, 0,  FSIZE*(sizes.length+vertices.length));
	gl.enableVertexAttribArray(a_Size);
    gl.enableVertexAttribArray(a_Position);
    gl.enableVertexAttribArray(a_Color);
	
	size_obj.val = ISIZE;
	return indexes.length;
}

function initVertexBuffers(gl,ind,matr) {
    const n = 3; // The number of vertices
    const sizes=new Float32Array([10.0, 20.0, 30.0]);
    const colors = new Float32Array([ 0.0, 1.0, 0.0, 1.0   ,0.0, 1.0, 0.0, 1.0,   1.0, 1.0, 1.0, 1.0]);
	//// для прозрачности
    // const sizes=new Float32Array([10.0, 20.0, 30.0,10.0, 20.0, 30.0]);
	//const colors = new Float32Array([ 0.0, 1.0, 0.0, 0.4 ,0.0, 1.0, 0.0, 0.4,  0.0, 1.0, 0.0, 0.4,   1.0, 0.0, 0.0, 0.4,1.0, 0.0, 0.0,0.4,1.0, 0.0, 0.0, 0.40]);
    const vertices = new Float32Array(2 * n);
	
    vertices[0] = 0.0;
    vertices[1] = 0.5;
    vertices[2] = -0.5;
    vertices[3] = -0.5;
    vertices[4] = 0.5;
    vertices[5] = -0.5;
	
	// vertices[6] = 0.0;
    // vertices[7] = -0.5;
    // vertices[8] = 0.5;
    // vertices[9] = 0.5;
    // vertices[10] = -0.5;
    // vertices[11] = 0.5;

  // Create a buffer object
    const vertexBuffer = gl.createBuffer();
    if (!vertexBuffer) {
		console.log('Failed to create the buffer object');
		return -1;
    }
    var FSIZE = vertices.BYTES_PER_ELEMENT;

  // Bind the buffer object to target
    gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer);
  // Write date into the buffer object
    gl.bufferData(gl.ARRAY_BUFFER, (vertices.length+sizes.length)*FSIZE+ colors.length*FSIZE, gl.STATIC_DRAW);
    gl.bufferSubData(gl.ARRAY_BUFFER, 0, sizes);
    gl.bufferSubData(gl.ARRAY_BUFFER, FSIZE*sizes.length, vertices);
    gl.bufferSubData(gl.ARRAY_BUFFER, FSIZE*(sizes.length+vertices.length), colors);
//gl.bufferSubData(gl.ARRAY_BUFFER, FSIZE*(sizes.length+vertices.length+ colors.length), gl_sizes);

    const a_Position = gl.getAttribLocation(gl.program, 'a_Position');
    if (a_Position < 0) {
		console.log('Failed to get the storage location of a_Position');
		return -1;
    }
  // Assign the buffer object to a_Position variable
  // gl.vertexAttribPointer(a_Position, 2, gl.FLOAT, false, 0, 0);

  //Enable the assignment to a_Position variable
  // gl.enableVertexAttribArray(a_Position);


// const sec_vertexBuffer = gl.createBuffer();
  // if (!vertexBuffer) {
    // console.log('Failed to create the buffer object');
    // return -1;
  // }

 // Bind the buffer object to target
  // gl.bindBuffer(gl.ARRAY_BUFFER, sec_vertexBuffer);
 // Write date into the buffer object
  // gl.bufferData(gl.ARRAY_BUFFER, sizes, gl.STATIC_DRAW);

    const a_Size = gl.getAttribLocation(gl.program, 'a_size');
	if (a_Size < 0) {
		console.log('Failed to get the storage location of a_Position');
		return -1;
    }
    const u_Width = gl.getUniformLocation(gl.program, 'u_Width');
    const u_Heigh = gl.getUniformLocation(gl.program, 'u_Heigh');
    const u_motion = gl.getUniformLocation(gl.program, 'motion');
    const a_Color = gl.getAttribLocation(gl.program, 'a_color');
  // const a_Width = gl.getAttribLocation(gl.program, 'a_Width');
  // if (a_Size < 0) {
    // console.log('Failed to get the storage location of a_Position');
    // return -1;
  // }
   // const a_Height = gl.getAttribLocation(gl.program, 'a_Height');
  // if (a_Size < 0) {
    // console.log('Failed to get the storage location of a_Position');
    // return -1;
  // }
    
    gl.uniform1f(u_Width, gl.drawingBufferWidth);
    gl.uniform1f(u_Heigh, gl.drawingBufferHeight);
   // let mat_r = glMatrix.mat4.create();
   // glMatrix.mat4.fromRotation(mat_r,Math.PI/3,[0,0,1]);
   // let mat_t= glMatrix.mat4.create();
   // if (ind==0)
     // glMatrix.mat4.fromTranslation(mat_t,[0.5,0.5,0.5,1.0]);
   // else
     // glMatrix.mat4.fromTranslation(mat_t,[0.0,0.0,0.0,1.0]);
   // let mat_s= glMatrix.mat4.create();
   // glMatrix.mat4.fromScaling(mat_s,[0.5,0.5,1.0,1.0]);
   // let mat_p= glMatrix.mat4.create();
   // glMatrix.mat4.multiply(mat_p,mat_t,mat_r);
   // glMatrix.mat4.multiply(mat_p,mat_p,mat_s);
	let mat_t = glMatrix.mat4.create();
    glMatrix.mat4.translate(mat_t,matr,[0.5,0.0,0.5,1.0]);
    let mat_s = glMatrix.mat4.create();
    glMatrix.mat4.scale(mat_s,mat_t,[0.5,0.5,1.0,1.0]);
	let out = glMatrix.mat4.create();
	glMatrix.mat4.lookAt(out, [0,0,-1], [0,0,1], [0,1,0])
    glMatrix.mat4.multiply(mat_s,mat_s,out);
    if (ind==0) 
	    gl.uniformMatrix4fv (u_motion, false, mat_s)
    else
		gl.uniformMatrix4fv (u_motion, false, matr)


    gl.vertexAttribPointer(a_Position, 2, gl.FLOAT, false, 0,  FSIZE*sizes.length);
    gl.vertexAttribPointer(a_Size, 1, gl.FLOAT, false, 0, 0);
    gl.vertexAttribPointer(a_Color, 4, gl.FLOAT, false, 0,  FSIZE*(sizes.length+vertices.length));
  
 // gl.vertexAttribPointer(a_Height, 1, gl.FLOAT, false, 0,  FSIZE*(sizes.length+vertices.length+ colors.length ));
  //gl.vertexAttribPointer(a_Width, 1, gl.FLOAT, false, 0,  FSIZE*(sizes.length+vertices.length+ colors.length));
  // Enable the assignment to a_Position variable
    gl.enableVertexAttribArray(a_Size);
    gl.enableVertexAttribArray(a_Position);
    gl.enableVertexAttribArray(a_Color);
  //gl.enableVertexAttribArray(a_Height);
 // gl.enableVertexAttribArray(a_Width);
  return n;
}


function initVertexBuffers(gl,indexes, coords, trans,color) {
	const n = indexes.length;
	let temp_size = []
	let temp_color = []
	//console.log("hi");
	flag = 0;
	const vertices = new Float32Array(3 * n);
	for (var i = 0; i<n; i++)
	{
		if (trans==-1)
		{trans = 0
	flag = 1;
	}
		vertices[i*3] = 0.5*coords[i*3+trans];
		//console.log(coords[i*3+trans])
		vertices[i*3+1] = 0.5*coords[i*3+trans+1];
		//console.log(coords[i*3+trans+1])
		vertices[i*3+2] =  0.5*coords[i*3+trans+2];
		//console.log(coords[i*3+trans+2])
		temp_size[i] = 10.0;
		temp_color[i*4] = color[0];
		temp_color[i*4+1] = color[0+1];
		temp_color[i*4+2] = color[0+2];
		temp_color[i*4+3] = color[0+3];
		
	}
	console.log(vertices)
	console.log("fffff")
	const sizes = new Float32Array(temp_size);
    const colors = new Float32Array(temp_color);
	
	const vertexBuffer = gl.createBuffer();
    if (!vertexBuffer) {
		console.log('Failed to create the buffer object');
		return -1;
    }
    var FSIZE = vertices.BYTES_PER_ELEMENT;

  // Bind the buffer object to target
    gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer);
  // Write date into the buffer object
    gl.bufferData(gl.ARRAY_BUFFER, (vertices.length+sizes.length)*FSIZE+ colors.length*FSIZE, gl.STATIC_DRAW);
    gl.bufferSubData(gl.ARRAY_BUFFER, 0, sizes);
    gl.bufferSubData(gl.ARRAY_BUFFER, FSIZE*sizes.length, vertices);
    gl.bufferSubData(gl.ARRAY_BUFFER, FSIZE*(sizes.length+vertices.length), colors);
//gl.bufferSubData(gl.ARRAY_BUFFER, FSIZE*(sizes.length+vertices.length+ colors.length), gl_sizes);


    const a_Position = gl.getAttribLocation(gl.program, 'a_Position');
    if (a_Position < 0) {
		console.log('Failed to get the storage location of a_Position');
		return -1;
    }
	 const a_Size = gl.getAttribLocation(gl.program, 'a_size');
	if (a_Size < 0) {
		console.log('Failed to get the storage location of a_Position');
		return -1;
    }
	const u_motion = gl.getUniformLocation(gl.program, 'motion');
	
	
	
    //при подключениии буфера глубины функция камеры работает неменее интересно. то, что мы можем ею посмотреть теперь не зависит от порядка рисовки
	//однако надо следить за тем, что стоит в точках взгляда и направления. координаты точки взгляда определяются без подвоха.
	//но направление определяется как то, что во взгляде, минус то, что во 2 параметре. если эта разность отрицатильна, мы смотри м в отрицательное направление оси oz, причем если там ничего больше нет, мы видим перед.
	//если разность нулевая, она считается как бы положительной.
	
	////ортогональная проекция передней грани
	// let out = glMatrix.mat4.create();
	// glMatrix.mat4.lookAt(out, [0,0,0.76], [0,0,0], [0,1,0]);
	// let ort = glMatrix.mat4.create();
	// glMatrix.mat4.ortho(ort, -0.5, 0.5,-0.5, 0.5, 0.01, 1)
	// glMatrix.mat4.multiply(out,ort,out);
	// gl.uniformMatrix4fv (u_motion, false, out);
	
	////ортогональная проекция задней грани
	// let out = glMatrix.mat4.create();
	// glMatrix.mat4.lookAt(out, [0,0,-0.3], [0,0,-0.2], [0,1,0]);
	// let ort = glMatrix.mat4.create();
	// glMatrix.mat4.ortho(ort, -0.5, 0.5,-0.5, 0.5, 0.01, 0.5)
	// glMatrix.mat4.multiply(out,ort,out);
	// gl.uniformMatrix4fv (u_motion, false, out);
	
	////ортогональная проекция верхней грани
	// let out = glMatrix.mat4.create();
	// glMatrix.mat4.lookAt(out, [0,0.45,0.0], [0,0,0], [0,0,-1]);
	// let ort = glMatrix.mat4.create();
	// glMatrix.mat4.ortho(ort, -0.75, 0.75,-0.75, 0.75, 0.01, 0.5)
	// glMatrix.mat4.multiply(out,ort,out);
	// gl.uniformMatrix4fv (u_motion, false, out);
	
	////ортогональная проекция боковой грани
	// let out = glMatrix.mat4.create();
	// glMatrix.mat4.lookAt(out, [0.3,0,0], [0.2,0,0], [0,1,0]);
	// let ort = glMatrix.mat4.create();
	// glMatrix.mat4.ortho(ort, -0.5, 0.5,-0.5, 0.5, 0.01, 0.5)
	// glMatrix.mat4.multiply(out,ort,out);
	// gl.uniformMatrix4fv (u_motion, false, out);
	
	////изометрическая проекция
	// let out = glMatrix.mat4.create();
	// glMatrix.mat4.lookAt(out, [0.3,0.3,0.3], [0,0,0], [0,1,0])
	// let ort = glMatrix.mat4.create();
	// glMatrix.mat4.ortho(ort, -0.5, 0.5,-0.5, 0.5, 0.01, 1.5)
	// glMatrix.mat4.multiply(out,ort,out);
	// gl.uniformMatrix4fv (u_motion, false, out)
	
	////аксонометрическая проекция
	// let out = glMatrix.mat4.create();
	// glMatrix.mat4.lookAt(out, [0.01,0.04,0.5], [0,0,0], [0,1,0])
	// let ort = glMatrix.mat4.create();
	// glMatrix.mat4.ortho(ort, -0.5, 0.5,-0.5, 0.5, 0.01, 1.8)
	////в данной функции параметры  - это рассттояния до плоскостей вдоль осей, а не координаты плоскостей.
	// glMatrix.mat4.multiply(out,ort,out);
	// gl.uniformMatrix4fv (u_motion, false, out)
	
	////perspective
	////одноточечная перспективная проекция
	 // let out = glMatrix.mat4.create();
	  
	 // if (flag == 0)
		  // glMatrix.mat4.lookAt(out, [0,0,0.8], [0,0,0.15], [0,1,0]);
		//glMatrix.mat4.translate(out,glMatrix.mat4.create(),[0,0.0,0.75]); 
	 // let ort = glMatrix.mat4.create();
	// glMatrix.mat4.perspective(ort,1.5, 1, 0.01, 100)
	// glMatrix.mat4.multiply(out,out,glMatrix.mat4.create());
	// glMatrix.mat4.multiply(out,ort,out);
	
	//console.log(out)
	//glMatrix.mat4.translate(out, out, [0, 0, -2]);
	 // gl.uniformMatrix4fv (u_motion, false, out)
	 
	 
	
	////двуточечная проекция
	// let out = glMatrix.mat4.create();
	// glMatrix.mat4.lookAt(out, [0.8,0,0.8], [0,0,0.15], [0,1,0]);
	// let ort = glMatrix.mat4.create();
	// glMatrix.mat4.perspective(ort,1.5, 1, 0.01, 100)
	// glMatrix.mat4.multiply(out,ort,out);
	// gl.uniformMatrix4fv (u_motion, false, out)
	
	
	////трехточечная проекция
	// let out = glMatrix.mat4.create();
	// glMatrix.mat4.lookAt(out, [0.8,0.8,0.8], [0,0,0], [0,1,0]);
	// let ort = glMatrix.mat4.create();
	// glMatrix.mat4.perspective(ort,1.5, 1, 0.01, 100)
	// glMatrix.mat4.multiply(out,ort,out);
	// gl.uniformMatrix4fv (u_motion, false, out)
	
	////frustum
	
	////одноточечная
	// let out = glMatrix.mat4.create();
	// glMatrix.mat4.lookAt(out, [0,0,1], [0,0,0], [0,1,0]);
	// let ort = glMatrix.mat4.create();
	//glMatrix.mat4.perspective(ort,1.5, 1, 0.01, 100)
	// glMatrix.mat4.frustum(ort, -0.25, 0.25, -0.25,0.25, 0.3, 1.5)
	// glMatrix.mat4.multiply(out,ort,out);
	// gl.uniformMatrix4fv (u_motion, false, out)


	////двуточечная
	// let out = glMatrix.mat4.create();
	// glMatrix.mat4.lookAt(out, [0.4,0,0.4], [0,0,0], [0,1,0]);
	// let ort = glMatrix.mat4.create();
	// glMatrix.mat4.frustum(ort, -0.25, 0.25, -0.25,0.25, 0.1, 1)
	// glMatrix.mat4.multiply(out,ort,out);
	// gl.uniformMatrix4fv (u_motion, false, out)

   ////трехточечная
	// let out = glMatrix.mat4.create();
	// glMatrix.mat4.lookAt(out, [0.4,0.3,0.4], [0,0,0], [0,1,0]);
	// let ort = glMatrix.mat4.create();
	// glMatrix.mat4.frustum(ort, -0.25, 0.25, -0.25,0.25, 0.1, 1)
	// glMatrix.mat4.multiply(out,ort,out);
	// gl.uniformMatrix4fv (u_motion, false, out)



	
	const a_Color = gl.getAttribLocation(gl.program, 'a_color');
	const u_Width = gl.getUniformLocation(gl.program, 'u_Width');
    const u_Heigh = gl.getUniformLocation(gl.program, 'u_Heigh');
	gl.uniform1f(u_Width, gl.drawingBufferWidth);
    gl.uniform1f(u_Heigh, gl.drawingBufferHeight);
	gl.vertexAttribPointer(a_Position, 3, gl.FLOAT, false, 0,  FSIZE*sizes.length);
    gl.vertexAttribPointer(a_Size, 1, gl.FLOAT, false, 0, 0);
    gl.vertexAttribPointer(a_Color, 4, gl.FLOAT, false, 0,  FSIZE*(sizes.length+vertices.length));
	gl.enableVertexAttribArray(a_Size);
    gl.enableVertexAttribArray(a_Position);
    gl.enableVertexAttribArray(a_Color);
	return n;
	
}