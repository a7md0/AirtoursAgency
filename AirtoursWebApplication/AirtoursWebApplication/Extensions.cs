﻿using System;

namespace AirtoursWebApplication {
    public static class Extensions {
        public static string NullIfWhiteSpace(this string value) {
            if (String.IsNullOrWhiteSpace(value)) { return null; }
            return value;
        }

        public static string DefaultIfWhiteSpace(this string value, string @default) {
            if (String.IsNullOrWhiteSpace(value)) { return @default; }
            return value;
        }
    }
}
