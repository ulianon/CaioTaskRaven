Shader "MyShaders/BOOOOAAAT"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
	}
		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100

		Pass
		{
			GLSLPROGRAM
			#ifdef VERTEX
			#include "UnityCG.glslinc"
			varying vec2 TextureCoordinate;

			void main()
			{
				vec4 saida = gl_ModelViewProjectionMatrix * gl_Vertex;
				gl_Position = saida + vec4(0, sin( _Time.z) * 0.5, 0, 0);
				TextureCoordinate = gl_MultiTexCoord0.xy;
			}

			#endif

			#ifdef FRAGMENT

			varying vec2 TextureCoordinate;
			uniform sampler2D _MainTex;

			void main()
			{

					gl_FragColor = texture2D(_MainTex, TextureCoordinate);

			}

			#endif

			ENDGLSL

		}
	}
}
