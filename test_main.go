package main

import "testing"

func testAPI(t *testing.T){
	t.Run("test API",func(t *testing.T){
		test:=[]struct{
			name string
			account Account
			cart Cart
		}{
			
		}
		for _,tt:=range test{
			t.Run(tt.name, func(t *testing.T) {
				
			})
		}
	})
}
