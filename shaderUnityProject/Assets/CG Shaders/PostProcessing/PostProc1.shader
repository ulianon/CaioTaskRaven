Shader "CameraProc/PostProc1"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_CenterX("CenterX", Float) = 0
		_CenterY("CenterY", Float) = 0
		_LengthCompare("LengthCompare", Float) = 0
		_Blur1D ("Blur1D", Range(0,10)) =  0 
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

			sampler2D _MainTex;
			float _CenterX;
			float _CenterY;
			float _LengthCompare;
			float _Blur1D;

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


			fixed4 frag(v2f i) : SV_Target
			{
			float proportion = _ScreenParams.x / _ScreenParams.y;
			float2 center = float2(proportion, 1);


			fixed4 col = tex2D(_MainTex, i.uv);


			if (length(center * (i.uv -.5f)) > _LengthCompare)
			{
				return col = (.5, .5, .5, 0.1);
			}

			for (float index = 0; index < 10; index++)
			{
				float2 uv = i.uv + float2 (0, (index / 9 - 0.5)*_Blur1D);
				col += tex2D(_MainTex, uv);
			}

			// just invert the colors
			//col.rgb = 1 - col.rgb;
			return col/10;
		}
		ENDCG
	}
		}
}
