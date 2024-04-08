Shader "Unlit/Trees"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_windDirection("windDirection", Vector) = (1,1,1,1) 
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

			float hash(float n)
			{
				return frac(sin(n)*43758.5453);
			}

			float noise(float3 x)
			{
				// The noise function returns a value in the range -1.0f -> 1.0f

				float3 p = floor(x);
				float3 f = frac(x);

				f = f * f*(3.0 - 2.0*f);
				float n = p.x + p.y*57.0 + 113.0*p.z;

				return lerp(lerp(lerp(hash(n + 0.0), hash(n + 1.0), f.x),
					lerp(hash(n + 57.0), hash(n + 58.0), f.x), f.y),
					lerp(lerp(hash(n + 113.0), hash(n + 114.0), f.x),
						lerp(hash(n + 170.0), hash(n + 171.0), f.x), f.y), f.z);
			}

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _windVector;
			
			v2f vert (appdata v)
			{
				v2f o;
				fixed4 col = tex2Dlod(_MainTex, float4(v.uv,1,1));
				if(col.y >0.5)
				{
				o.vertex = UnityObjectToClipPos(v.vertex + float4(0.05, sin(_Time.z)/18, 0.1, 0.1) *length(float3(v.vertex.x,0,v.vertex.z) 
					*noise(_Time.z + v.vertex.x))) ;
				}
				else
				{
				o.vertex = UnityObjectToClipPos(v.vertex);
				}
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
				//return fixed4(col * i.normal * clamp(sin(_Time.z * 50) * 5, 0.7, 2) * brightness, 1);
				return fixed4(col * i.normal * brightness +0.25, 1);




				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
			}
			ENDCG
		}
	}
}
