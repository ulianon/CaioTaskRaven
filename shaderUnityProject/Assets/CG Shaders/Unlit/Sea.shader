﻿Shader "Unlit/CGSea"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" "Lightmode" = "ForwardBase" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
				float3 normal : NORMAL;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex)  + float4(0, sin(v.vertex.x + _Time.z) * 0.5,0,0) + float4(sin(v.vertex.x + _Time.z) * 0.2, 0, 0, 0);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.normal = v.normal;
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture

				_WorldSpaceLightPos0;
				fixed4 col = tex2D(_MainTex, i.uv);

				float brightness = dot(normalize(_WorldSpaceLightPos0).xyz, i.normal);
				return fixed4(col * brightness + sin(_Time.z) *0.02 + 0.05);




				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
			}
			ENDCG
		}
	}
}
