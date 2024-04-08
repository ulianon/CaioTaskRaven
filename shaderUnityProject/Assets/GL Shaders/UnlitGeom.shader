Shader "Unlit/Unlitgeom"
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
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma geometry Geometry
			// make fog work
			#pragma multi_compile_fog

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
			};

			struct v2g
			{
				float4 position : POSITION;
				float3 normal : NORMAL;
				float4 tangent : TANGENT;
				float2 uv : TEXCOORD;
			};

			// Fragment varyings
			struct g2f
			{
				float4 position : SV_POSITION;
				float3 normal : NORMAL;
				float4 tangent : TANGENT;
				float2 uv : TEXCOORD0;

			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			//geometry porra
			v2g vert(appdata v)
			{
				v2g o;
				o.position = UnityObjectToClipPos(v.vertex) + float4(0, sin(v.vertex.x + _Time.z) * 0.5, 0, 0) + float4(sin(v.vertex.x + _Time.z) * 0.2, 0, 0, 0);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				//o.uv = v.uv;
				return o;

			}

			[maxvertexcount(15)]
			void Geometry(triangle v2g input[3], inout TriangleStream<g2f> outStream)
			{

				outStream.Append(input[0]);
				outStream.Append(input[1]);
				outStream.Append(input[2]);
				outStream.RestartStrip();

				v2g in1 = input[0];
				in1.position = input[0].position + float4(1, sin(_Time.z) -1 * 1.000001, 1, 1);
				v2g in2 = input[1];
				in2.position = input[1].position + float4(1, cos(_Time.z) - 1 * 1.000001, 1, 1);
				v2g in3 = input[2];
				in3.position = input[2].position + float4(1, cos(_Time.z) - 1 * 1.000001, 1, 1);


				outStream.Append(in1);
				outStream.Append(in2);
				outStream.Append(in3);


				outStream.RestartStrip();

				v2g in4 = input[0];
				in4.position = input[0].position + in3.position + float4(1, sin(_Time.z) - 1 * 1.000001, 1, 1);
				v2g in5 = input[1];
				in5.position = input[1].position + in2.position + float4(1, cos(_Time.z) - 1 * 1.000001, 1, 1);
				v2g in6 = input[2];
				in6.position = input[2].position + in1.position + float4(1, cos(_Time.z) - 1 * 1.000001, 1, 1);

				outStream.Append(in4);
				outStream.Append(in5);
				outStream.Append(in6);

			}

			fixed4 frag(g2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
			// apply fog

			return col;
		}
		ENDCG
	}
	}
}
