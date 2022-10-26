package pgdp.functions;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.assertFalse;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

public class FunctionsTest {
    @Test
    @DisplayName("Should calculate the power of 3")
    public void testCube() {
        assertEquals(Functions.cube(-2), -8);
        assertEquals(Functions.cube(-1), -1);
        assertEquals(Functions.cube(0), 0);
        assertEquals(Functions.cube(1), 1);
        assertEquals(Functions.cube(2), 8);
    }

    @Test
    @DisplayName("Should calculate the average of 3 numbers")
    public void testAverage() {
        assertEquals(Functions.average(1, 1, 1), 1);
        assertEquals(Functions.average(5, 10, 15), 10);
    }

    @Test
    @DisplayName("Should return if the c is a pythagorean triple")
    public void testIsPythagoreanTriple() {
        assertFalse(Functions.isPythagoreanTriple(1, 1, 1));
        assertTrue(Functions.isPythagoreanTriple(3,4,5));
    }
}
