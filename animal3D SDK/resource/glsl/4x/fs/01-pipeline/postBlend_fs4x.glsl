/*
	Copyright 2011-2021 Daniel S. Buckstein

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

		http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
*/

/*
	animal3D SDK: Minimal 3D Animation Framework
	By Daniel S. Buckstein
	
	postBlend_fs4x.glsl
	Blending layers, composition.
*/

#version 450

//https://learnopengl.com/Advanced-Lighting/Bloom

// ****DONE:
//	-> declare texture coordinate varying and set of input textures
//	-> implement some sort of blending algorithm that highlights bright areas
//		(hint: research some Photoshop blend modes)

layout (location = 0) out vec4 rtFragColor;

// textures 
layout (binding = 0) uniform sampler2D sceneTexture;
layout (binding = 1) uniform sampler2D vBlur2;
layout (binding = 2) uniform sampler2D vBlur4;
layout (binding = 3) uniform sampler2D vBlur8;

in vec4 vTexcoord_atlas;

void main()
{
	// DUMMY OUTPUT: all fragments are OPAQUE PURPLE
	//rtFragColor = vec4(0.5, 0.0, 1.0, 1.0);

	vec4 testBlend = 1.0 - (1.0 - texture2D(sceneTexture, vTexcoord_atlas.xy)) * (1.0 - texture2D(vBlur2, vTexcoord_atlas.xy)) 
	* (1.0 - texture2D(vBlur4, vTexcoord_atlas.xy)) * (1.0 - texture2D(vBlur8, vTexcoord_atlas.xy));

	rtFragColor = testBlend;
}
