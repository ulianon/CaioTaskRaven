Shader "Hidden/Pixelated"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
	_Float("float", Float) = 10
	}
		SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			sampler2D _MainTex;
			float _Float;

			fixed4 frag(v2f i) : SV_Target
			{
			float2 stepped = i.uv;
			stepped /= _Float / _ScreenParams.xy;
			stepped = round(stepped);
			stepped *= _Float / _ScreenParams.xy;
				return tex2D(_MainTex, stepped);
			}
			ENDCG
		}
	}
}
