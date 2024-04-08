Shader "MyShaders/SEAAAAAA"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
	}
		SubShader
	{
		Tags { "Queue" = "Geometry" }
		LOD 100

		Pass
		{
			GLSLPROGRAM
			#ifdef VERTEX
			#include "UnityCG.glslinc"
			varying vec2 TextureCoordinate;
			varying vec3 normal;

			void main()
			{
				vec4 saida = gl_ModelViewProjectionMatrix * gl_Vertex;
				normal = gl_Normal.xyz;
				gl_Position = saida + vec4(0, sin(gl_Vertex.z + _Time.z) * 0.9, 0, 0);
				TextureCoordinate = gl_MultiTexCoord0.xy;
			}

			#endif

			#ifdef FRAGMENT

			varying vec2 TextureCoordinate;
			varying vec3 normal;
			uniform sampler2D _MainTex;

			void main()
			{
				float brightness2 = 1;
				gl_FragColor = texture2D(_MainTex, TextureCoordinate) * clamp(brightness2, 0.3, brightness2 + 2);

			}

			#endif

			ENDGLSL

		}
	}
}
